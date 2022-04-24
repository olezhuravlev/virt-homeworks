package hashicups

import (
	"context"
	"encoding/json"
	"fmt"
	"github.com/hashicorp/terraform-plugin-sdk/v2/diag"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
	"net/http"
	"strconv"
	"time"
)

// This function defines the 'coffees' schema.
func dataSourceCoffees() *schema.Resource {
	return &schema.Resource{
		ReadContext: dataSourceCoffeesRead,
		Schema: map[string]*schema.Schema{
			"coffees": &schema.Schema{
				Type:     schema.TypeList,
				Computed: true,
				// The coffee resource's properties should map to their respective values in the JSON response!
				Elem: &schema.Resource{
					Schema: map[string]*schema.Schema{
						"id": &schema.Schema{
							Type:     schema.TypeInt,
							Computed: true,
						},
						"name": &schema.Schema{
							Type:     schema.TypeString,
							Computed: true,
						},
						"teaser": &schema.Schema{
							Type:     schema.TypeString,
							Computed: true,
						},
						"description": &schema.Schema{
							Type:     schema.TypeString,
							Computed: true,
						},
						"price": &schema.Schema{
							Type:     schema.TypeInt,
							Computed: true,
						},
						"image": &schema.Schema{
							Type:     schema.TypeString,
							Computed: true,
						},
						"ingredients": &schema.Schema{
							Type:     schema.TypeList,
							Computed: true,
							Elem: &schema.Resource{
								Schema: map[string]*schema.Schema{
									"ingredient_id": &schema.Schema{
										Type:     schema.TypeInt,
										Computed: true,
									},
								},
							},
						},
					},
				},
			},
		},
	}
}

// This function creates a new GET request to localhost:19090/coffees.
// Returns diag.Diagnostics type, which can return multiple errors and warnings to Terraform, giving users more
// robust error and warning messages.
func dataSourceCoffeesRead(ctx context.Context, d *schema.ResourceData, m interface{}) diag.Diagnostics {
	client := &http.Client{Timeout: 10 * time.Second}

	// Warning or errors can be collected in a slice type
	var diags diag.Diagnostics

	req, err := http.NewRequest("GET", fmt.Sprintf("%s/coffees", "http://localhost:19090"), nil)
	if err != nil {
		return diag.FromErr(err)
	}

	r, err := client.Do(req)
	if err != nil {
		return diag.FromErr(err)
	}
	defer r.Body.Close()

	coffees := make([]map[string]interface{}, 0)
	err = json.NewDecoder(r.Body).Decode(&coffees)
	if err != nil {
		return diag.FromErr(err)
	}

	if err := d.Set("coffees", coffees); err != nil {
		return diag.FromErr(err)
	}

	// always run
	d.SetId(strconv.FormatInt(time.Now().Unix(), 10))

	return diags
}
