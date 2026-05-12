Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A1C3AEB2B;
	Tue, 12 May 2026 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598614; cv=none; b=RFZKbFqFicKluHKfxf3hTCbrcS7aRs73GzMxxTRgaQPzOxYMRLgs6zRq/E06wxnUrVhHcWfbfFscggcnJEdQS+ADaQMJTbazVs+hr3Mg4MEtuPyOdW+b+DqY6oDl1FtVfXmJTLFaudvK2wBLaBVtxL8AQDZVxwHvlVD2BzCxvhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598614; c=relaxed/simple;
	bh=AwZ1ILjhydP03cFGJ0iPjOyonN56LkioZWITTJgz5RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3jLOTE8cCURazprfHzeM3a4Xwyzyvx7uRoPqwI5ruF3L6fNEC6DcTnhUeNbGi6QM2BaCuKn6YkMYvGjNftEG/QRJodbJKXdLxscqXF37azlG1rnexmiJRyUCBY4OpLIOh2qA3aYoJ09sEf69ls12+Y3WcbopclLdIY4EQt/VZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VBaNM4q5; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VBaNM4q5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8a8fVTOm7NIfOqX3i9o33WdWb5aUpm3fCdKruyf2uwc=; b=VBaNM4q5YqZyWkfgF+xwje+BzB
	uDvS88FkMgmDGw+ENEuJv4iTxVrccmxlDFo9Ix0vVyH2ljbKtK0/kxdibp3JyCYQnoy3HxuhIdRvT
	16HxhCO39zUZd2L/nkXZOMDzR2S6OmncxepLTrT3/nNeNEB6OTmkgzKXzkbhZcMNQD3wdHmpzuxhH
	TL5PMYc4HPojgSqI8O0zUJInvykkbgpfW/6MTWw/doL2U3xh47Skoew/S03T9BIF900krOu9Qcg7g
	LazyQtbgVv/T1HjTXuZq3aX0v1OOMeXFqKGXvEa+LE5NPb5Ws9aESFsatpuArI9XOlrQbtwaBcdkC
	rWcOKIBg==;
Received: from 179-125-79-241-dinamico.pombonet.net.br ([179.125.79.241] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wMokC-009Whm-HZ; Tue, 12 May 2026 17:10:00 +0200
Date: Tue, 12 May 2026 12:09:55 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	platform-driver-x86@vger.kernel.org,
	Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: Re: [PATCH v2 00/10] platform/x86: classmate-laptop: Bind to
 platform devices instead of ACPI ones
Message-ID: <agNCw7_AL-PIemmO@quatroqueijos.cascardo.eti.br>
References: <3415394.44csPzL39Z@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3415394.44csPzL39Z@rafael.j.wysocki>

On Mon, May 11, 2026 at 10:01:45PM +0200, Rafael J. Wysocki wrote:
> Hi All,
> 
> This is an update of
> 
> https://lore.kernel.org/linux-acpi/1956046.tdWV9SEqCh@rafael.j.wysocki/
> 
> sent mostly because I have realized that using devm_kzalloc() in the first
> patch simplifies things going forward, but also it adds ACPI companion
> checks against NULL at probe time that were missing previously.
> 
> This series is part of a larger effort to switch over all drivers using
> the struct acpi_driver interface to the more common struct platform_driver
> interface and eliminate the former.  The background is explained in
> Documentation/driver-api/acpi/acpi-drivers.rst and in the changelog of
> the patch that introduced the above document:
> 
> https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/
> 
> The bottom line is that the kernel would be better off without struct
> acpi_driver and so it is better to get rid of it.
> 
> This series carries out driver conversion of 5 subdrivers in the platform x86
> classmate-laptop driver.
> 
> The first 5 patches in the series are preliminary.
> 
> Patch [01/10] converts two subdrivers in classmate-laptop to using
> devm_kzalloc() for allocating memory which helps to avoid memory leaks
> during driver removal.
> 
> Patch [02/10] modifies 2 subdrivers in classmate-laptop so that their probe
> rollback code ordering is the same as the removal one.
> 
> Patches [03-04/10] change the type of the first argument in 2 helper functions
> in classmate-laptop and rename them.
> 
> Patch [05/10] updates classmate-laptop subdrivers to install their own ACPI
> notify handlers instead of using the .notify() callback in struct acpi_driver.
> 
> The remaining patches convert the classmate-laptop subdrivers to platform
> drivers, one at a time.
> 
> Patch [06/10] converts the accel-v4 subdriver in classmate-laptop to using
> struct platform_driver for device binding.
> 
> Patch [07/10] converts the accel subdriver in classmate-laptop to using
> struct platform_driver for device binding.
> 
> Patch [08/10] converts the tablet subdriver in classmate-laptop to using
> struct platform_driver for device binding.
> 
> Patch [09/10] converts the ipml subdriver in classmate-laptop to using
> struct platform_driver for device binding.
> 
> Patch [10/10] converts the keys subdriver in classmate-laptop to using
> struct platform_driver for device binding.
> 
> Thanks!
> 
> 
> 
> 

For the whole series:

Acked-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
