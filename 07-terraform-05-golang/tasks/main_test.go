package main

import "testing"

func TestFeetConvertor(t *testing.T) {
	got := FeetConvertor(10)
	want := float64(3.05)
	if got != want {
		t.Errorf("Must be %0.2f but %0.2f returned", want, got)
	}
}

func TestFindMin(t *testing.T) {
	resultEmpty := FindMin([]int{})
	if resultEmpty != nil {
		t.Errorf("Must be empty reference!")
	}

	result := FindMin([]int{48, 96, 86, 68, 57, 82, 63, 70, 37, 34, 83, 27, 19, 97, 9, 17})
	if result == nil {
		t.Errorf("Must be actual reference!")
	}

	got := *result
	want := 9

	if got != want {
		t.Errorf("Must be %d but %d returned", want, got)
	}
}

func TestShowDevisibleBy(t *testing.T) {
	got := ShowDevisibleBy(1, 10, 3)
	want := 3
	if len(got) != want {
		t.Errorf("Must be %d long but is %d", want, len(got))
		return
	}

	wanted_result := []int{3, 6, 9}
	for i := range wanted_result {
		if wanted_result[i] != got[i] {
			t.Errorf("Must be %d long but is %d", wanted_result, got)
			return
		}
	}
}
