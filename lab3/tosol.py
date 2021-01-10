def tosol( x, infA, supA, infb, supb ):
	mintol = 1e10

	for i in range(infA.shape[0]):
		radb = supb[i] - infb[i]
		midb = infb[i] + 0.5 * radb
		axinf = 0
		axsup = 0
		for j in range(infA.shape[1]):
			axinf += infA[i, j] * x[j]
			axsup += supA[i, j] * x[j]
		tol = radb - max(abs(midb - axinf), abs(midb - axsup))
		mintol = min(mintol, tol)
	return mintol

