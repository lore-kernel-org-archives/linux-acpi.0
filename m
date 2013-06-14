From: Larry Baker <baker@usgs.gov>
Subject: Re: Wishlist: Disable C6 in intel_idle for Model 44 processors
Date: Fri, 14 Jun 2013 13:23:16 -0700
Message-ID: <45BB9A08-C71E-4AE0-B401-7892E0E50C56@usgs.gov>
References: <38D8523B-C50E-4D81-A9E2-526292B19AF3@usgs.gov> <20130612134002.GA15317@srcf.ucam.org> <1BD2BF18-8FAA-4633-8B6D-7CA2D6AE67AC@usgs.gov> <20130612183249.GA20957@srcf.ucam.org> <CAJvTdKkAy3P=vL=Z5yy31FTvrPNx=Bv11zq-XPi+HeexL=90dg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from SMTP6.doi.gov ([137.227.28.12]:15607 "EHLO smtp6.doi.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753133Ab3FNUXX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Jun 2013 16:23:23 -0400
Received: by mail-pa0-f53.google.com with SMTP id tj12so975176pac.40
        for <linux-acpi@vger.kernel.org>; Fri, 14 Jun 2013 13:23:19 -0700
 (PDT)
In-Reply-To: <CAJvTdKkAy3P=vL=Z5yy31FTvrPNx=Bv11zq-XPi+HeexL=90dg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux acpi <linux-acpi@vger.kernel.org>, Rob E Russell <robr@us.ibm.com>

Len,

I like your proposal to run this by the hardware boys.  I'd like to hea=
r what they say about 1) how likely the problem is (certain DIMM brands=
/models?), 2) what they recommend to avoid the system failure/lockup, a=
nd 3) whether Linux can help work around the errata.  I think my IBM su=
pport person was going to try to ask about this through his contacts at=
 Intel as well.

I'm not a BIOS programmer at all.  In the old days, BIOS's could (had t=
o?) set up memory controllers.  I remember mucking with CAS settings.  =
Then came SPD, and BIOS's would either use those settings or let you ov=
erride them.  Those memory controllers were separate devices on the bus=
, and I am sure there were registers to set them up.  Now that memory c=
ontrollers are built into the processors, I don't know if that is possi=
ble any more.  I glanced through the two volume Intel Xeon Processor 55=
00 Series Datasheet (http://www.intel.com/content/dam/www/public/us/en/=
documents/datasheets/xeon-5500-vol-1-datasheet.pdf, http://www.intel.co=
m/content/dam/www/public/us/en/documents/datasheets/xeon-5500-vol-2-dat=
asheet.pdf), also a Nehalem core, and I didn't see any registers to con=
trol DRAM voltages (V-DDQ, I think).  I did find where it said (7.5 Enh=
anced Intel SpeedStep=AE Technology) "The processor controls voltage ra=
mp rates internally to ensure smooth transitions."  That's as much as I=
 could find about DRAM voltage control.

I agree, and I do run the latest BIOS from IBM.  My mention of the two =
low-latency tips documents I found on the web was only to give a refere=
nce for the description of how intel_idle works.  I found those while I=
 was trying to understand the issue -- before I looked for the source c=
ode.  I do not need such extreme measures.  In fact, I prefer to keep t=
hings as cool as possible (the reason I use an L series product) for re=
liability.

Thanks for your informative comments.

Larry Baker
US Geological Survey
650-329-5608
baker@usgs.gov



On 14 Jun 2013, at 12:32 PM, Len Brown wrote:

> Hi Larry,
>=20
> Thanks for the note.
>=20
> I use two Westmere systems:
> An Extreme Edition X980 on an Intel DX58SO motherboard,
> and a pair of Xeon X5680's on a Intel S5520SC motherboard.
>=20
> Both processors model 0x2c, and thus subject to this errata.
>=20
> Both system are running the latest BIOS and firmware from Intel.
> Both systems enable and use CC6 and PC6, by default.
> This is true whether they are running ACPI idle
> (such as Windows would do, or acpi_idle in Linux)
> or Linux's intel_idle driver.
>=20
> This suggests that the fix is not to disable PC6 on model 0x2c.
> I would expect, as Matthew does, that the "BIOS workaround"
> is likely something to do with how the BIOS initialization code sets
> up the memory controller...  But in the event that the real fix
> is to disable PC6 and Intel itself has not updated its own BIOS
> to comply with its own errata, I'll contact the hardware designers
> to see if I can get a more fact-based response.
>=20
> So I concur with Matthew.
> If you are concerned about configuration of your chip-set,
> then you want to run the latest BIOS from the the vendor.
> A Linux workaround doesn't currently look warranted.
>=20
> thanks,
> -Len Brown, Intel Open Source Technology Center
>=20
> ps.
>=20
> Yes, we have an issue that intel_idle doesn't respect when
> the BIOS "disables" C-states via ACPI tables.  Indeed,
> part of the value proposition of intel_idle is that it is immune
> to ACPI table bugs that crop up from system to system.
> Also, intel_idle is not subject to some of the limitations of ACPI.
> We believe this is one of the reasons that Linux on Intel
> is better than some other operating systems on Intel.
>=20
> The OEMs such as Dell, HP and IBM are accustomed to having
> control in the BIOS and so they are unhappy about losing
> that capability.  We do hear them, but unfortunately it will
> likely be the Haswell Server generation before we can give their
> BIOS programmers that absolute control back by
> empowering them to modify CPUID.MWAIT.EDX --
> which is how the HW enumerates C-states.
>=20
> This issue comes up mostly when latency sensitive
> customers want to disable the high latency C-states.
> In the past, the OEM could configure their BIOS to
> handle that situation.  But with modern Linux,
> a cmdline param such as intel_idle.max_cstate=3DN
> is necessary.  OEM's don't like Linux cmdline params,
> they prefer BIOS control.
>=20
> As Matthew pointed out, the Linux community believes
> that the answer for latency-sensitive customers is
> to use Linux PM-QOS to tell the machine how
> the customer wants it to run.  From a Linux point
> of view, this is a universal solution, it requires
> no BIOS SETUP tweaks and no kernel cmdline parms.
>=20
> BTW. If the workaround for the errata were actually
> to disable C6, it would be (Package) PC6, not (Core) CC6.
> The BIOS already has control over Package C-states,
> and if the BIOS doesn't lock the MSR, Linux also
> has that capability.
>=20
> Get the latest turbostat from the kernel tree
> and run turbostat -v
> and look for a line like this:
>=20
> cpu0: MSR_NHM_SNB_PKG_CST_CFG_CTL: 0x06008403 (demote-C3, demote-C1,
> locked: pkg-cstate-limit=3D3: pc6)
>=20
> cpu0: MSR_NHM_SNB_PKG_CST_CFG_CTL: 0x06000403 (demote-C3, demote-C1,
> UNlocked: pkg-cstate-limit=3D3: pc6)
>=20
> As described in the Intel Software Developer's Manual,
> this MSR, MSR_PKG_CST_CONFIG_CONTROL has a package C-state limit fiel=
d.
> Above it limits the hardware to PC6, but could easily be set to PC3.
>=20
> In one of the examples above, the register was locked by the BIOS,
> preventing Linux from modifying it, in the 2nd example, it is unlocke=
d.
>=20
> if we limited the package to PC3 here, then Linux would still choose =
CC6,
> but when all the cores entered CC6, the deepest the package would
> go would be PC3.

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
