From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 2.5.54] cpufreq-ACPI: deprecated usage of CPUFREQ_ALL_
	CPUS
Date: Wed, 8 Jan 2003 17:06:15 -0800
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A110@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Dominik Brodowski [mailto:linux-JhLEnvuH02M@public.gmane.org] 
> Deprecated usage of CPUFREQ_ALL_CPUS: as policy->cpu now only points
> to an existing CPU, some code can safely be removed from the ACPI
> P-States cpufreq driver.

OK thanks, applied.

BTW Dominik in the future don't feel you need to submit cpufreq-ACPI
patches through me - although a CC would still be nice. ;-)

Regards -- Andy
