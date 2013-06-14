From: Larry Baker <baker@usgs.gov>
Subject: Re: Wishlist: Disable C6 in intel_idle for Model 44 processors
Date: Fri, 14 Jun 2013 15:40:54 -0700
Message-ID: <9F8744DC-F931-4129-B8F0-72CC7F39DAAF@usgs.gov>
References: <38D8523B-C50E-4D81-A9E2-526292B19AF3@usgs.gov> <20130612134002.GA15317@srcf.ucam.org> <1BD2BF18-8FAA-4633-8B6D-7CA2D6AE67AC@usgs.gov> <20130612183249.GA20957@srcf.ucam.org> <CAJvTdKkAy3P=vL=Z5yy31FTvrPNx=Bv11zq-XPi+HeexL=90dg@mail.gmail.com> <45BB9A08-C71E-4AE0-B401-7892E0E50C56@usgs.gov> <OF3D706B0A.D5540D6C-ON85257B8A.0076278F-85257B8A.0076E4B1@us.ibm.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from SMTP1.doi.gov ([137.227.82.11]:31735 "EHLO smtp1.doi.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753386Ab3FNWlA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Jun 2013 18:41:00 -0400
Received: by mail-pd0-f176.google.com with SMTP id t12so983051pdi.21
        for <linux-acpi@vger.kernel.org>; Fri, 14 Jun 2013 15:40:57 -0700
 (PDT)
Received: from savaii.wr.usgs.gov (u-130-118-45-7.xr.usgs.gov. [130.118.45.7])
        by mx.google.com with ESMTPSA id
 vu5sm3967059pab.10.2013.06.14.15.40.56        for
 <linux-acpi@vger.kernel.org>        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA
 bits=128/128);        Fri, 14 Jun 2013 15:40:56 -0700 (PDT)
In-Reply-To: <OF3D706B0A.D5540D6C-ON85257B8A.0076278F-85257B8A.0076E4B1@us.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: linux acpi <linux-acpi@vger.kernel.org>

Rob,

I think I found the description of the "Driver Impedance" fix in the IB=
M uEFI firmware at http://www-947.ibm.com/support/entry/portal/docdispl=
ay?lndocid=3Dmigr-5091950.  I'm puzzled by the Workaround section.  I s=
till can't tell from this if the "Driver Impedance" setting is or is no=
t ignored by intel_idle.  Anyway, I hope the hardware boys can say if i=
ntel_idle should force this "Driver Impedance" setting on these process=
ors (assuming that is possible) when it wants to use C states.

Larry Baker
US Geological Survey
650-329-5608
baker@usgs.gov



On 14 Jun 2013, at 2:39 PM, Rob E Russell wrote:

> Larry,=20
>=20
> The fix from an IBM uEFI standpoint was to include an option in syste=
m settings called "Driver Impedance" in uEFI v1.16.  If the user wants =
C-states to work, then driver impedance should also be enabled to avoid=
 this package C6 transition issue.   If the user does not care about C-=
states, then on Linux, the intel_idle driver should be disabled.   C-st=
ates are disabled by default in uEFI system settings.
>=20
> Regards,=20
> Rob Russell
> Technical Sales Support, IBM System x, US Federal Government
> Phone: (720) 396-2235, TL 938-2235, Cell: 919-389-4874
> <Mail Attachment.jpeg>	Phone: 1-720-396-2235 | Phone: 1-919-651-1294 =
| Mobile: 1-919-389-4874
> E-mail: robr@us.ibm.com=09
> <Mail Attachment.gif>
>=20
> 3500 Blue Lake Dr
> Birmingham, AL 35243-1900
> United States
>=20
>=20
>=20
>=20
>=20
> From:        Larry Baker <baker@usgs.gov>=20
> To:        Len Brown <lenb@kernel.org>,=20
> Cc:        Matthew Garrett <mjg59@srcf.ucam.org>, linux acpi <linux-a=
cpi@vger.kernel.org>, Rob E Russell/Raleigh/IBM@IBMUS=20
> Date:        06/14/2013 04:23 PM=20
> Subject:        Re: Wishlist: Disable C6 in intel_idle for Model 44 p=
rocessors=20
>=20
>=20
>=20
> Len,
>=20
> I like your proposal to run this by the hardware boys.  I'd like to h=
ear what they say about 1) how likely the problem is (certain DIMM bran=
ds/models?), 2) what they recommend to avoid the system failure/lockup,=
 and 3) whether Linux can help work around the errata.  I think my IBM =
support person was going to try to ask about this through his contacts =
at Intel as well.
>=20
> I'm not a BIOS programmer at all.  In the old days, BIOS's could (had=
 to?) set up memory controllers.  I remember mucking with CAS settings.=
  Then came SPD, and BIOS's would either use those settings or let you =
override them.  Those memory controllers were separate devices on the b=
us, and I am sure there were registers to set them up.  Now that memory=
 controllers are built into the processors, I don't know if that is pos=
sible any more.  I glanced through the two volume Intel Xeon Processor =
5500 Series Datasheet (http://www.intel.com/content/dam/www/public/us/e=
n/documents/datasheets/xeon-5500-vol-1-datasheet.pdf, http://www.intel.=
com/content/dam/www/public/us/en/documents/datasheets/xeon-5500-vol-2-d=
atasheet.pdf), also a Nehalem core, and I didn't see any registers to c=
ontrol DRAM voltages (V-DDQ, I think).  I did find where it said (7.5 E=
nhanced Intel SpeedStep=AE Technology) "The processor controls voltage =
ramp rates internally to ensure smooth transitions."  That's as much as=
 I could find about DRAM voltage control.
>=20
> I agree, and I do run the latest BIOS from IBM.  My mention of the tw=
o low-latency tips documents I found on the web was only to give a refe=
rence for the description of how intel_idle works.  I found those while=
 I was trying to understand the issue -- before I looked for the source=
 code.  I do not need such extreme measures.  In fact, I prefer to keep=
 things as cool as possible (the reason I use an L series product) for =
reliability.
>=20
> Thanks for your informative comments.
>=20
> Larry Baker
> US Geological Survey
> 650-329-5608
> baker@usgs.gov
>=20
>=20
>=20
> On 14 Jun 2013, at 12:32 PM, Len Brown wrote:
>=20
> > Hi Larry,
> >=20
> > Thanks for the note.
> >=20
> > I use two Westmere systems:
> > An Extreme Edition X980 on an Intel DX58SO motherboard,
> > and a pair of Xeon X5680's on a Intel S5520SC motherboard.
> >=20
> > Both processors model 0x2c, and thus subject to this errata.
> >=20
> > Both system are running the latest BIOS and firmware from Intel.
> > Both systems enable and use CC6 and PC6, by default.
> > This is true whether they are running ACPI idle
> > (such as Windows would do, or acpi_idle in Linux)
> > or Linux's intel_idle driver.
> >=20
> > This suggests that the fix is not to disable PC6 on model 0x2c.
> > I would expect, as Matthew does, that the "BIOS workaround"
> > is likely something to do with how the BIOS initialization code set=
s
> > up the memory controller...  But in the event that the real fix
> > is to disable PC6 and Intel itself has not updated its own BIOS
> > to comply with its own errata, I'll contact the hardware designers
> > to see if I can get a more fact-based response.
> >=20
> > So I concur with Matthew.
> > If you are concerned about configuration of your chip-set,
> > then you want to run the latest BIOS from the the vendor.
> > A Linux workaround doesn't currently look warranted.
> >=20
> > thanks,
> > -Len Brown, Intel Open Source Technology Center
> >=20
> > ps.
> >=20
> > Yes, we have an issue that intel_idle doesn't respect when
> > the BIOS "disables" C-states via ACPI tables.  Indeed,
> > part of the value proposition of intel_idle is that it is immune
> > to ACPI table bugs that crop up from system to system.
> > Also, intel_idle is not subject to some of the limitations of ACPI.
> > We believe this is one of the reasons that Linux on Intel
> > is better than some other operating systems on Intel.
> >=20
> > The OEMs such as Dell, HP and IBM are accustomed to having
> > control in the BIOS and so they are unhappy about losing
> > that capability.  We do hear them, but unfortunately it will
> > likely be the Haswell Server generation before we can give their
> > BIOS programmers that absolute control back by
> > empowering them to modify CPUID.MWAIT.EDX --
> > which is how the HW enumerates C-states.
> >=20
> > This issue comes up mostly when latency sensitive
> > customers want to disable the high latency C-states.
> > In the past, the OEM could configure their BIOS to
> > handle that situation.  But with modern Linux,
> > a cmdline param such as intel_idle.max_cstate=3DN
> > is necessary.  OEM's don't like Linux cmdline params,
> > they prefer BIOS control.
> >=20
> > As Matthew pointed out, the Linux community believes
> > that the answer for latency-sensitive customers is
> > to use Linux PM-QOS to tell the machine how
> > the customer wants it to run.  From a Linux point
> > of view, this is a universal solution, it requires
> > no BIOS SETUP tweaks and no kernel cmdline parms.
> >=20
> > BTW. If the workaround for the errata were actually
> > to disable C6, it would be (Package) PC6, not (Core) CC6.
> > The BIOS already has control over Package C-states,
> > and if the BIOS doesn't lock the MSR, Linux also
> > has that capability.
> >=20
> > Get the latest turbostat from the kernel tree
> > and run turbostat -v
> > and look for a line like this:
> >=20
> > cpu0: MSR_NHM_SNB_PKG_CST_CFG_CTL: 0x06008403 (demote-C3, demote-C1=
,
> > locked: pkg-cstate-limit=3D3: pc6)
> >=20
> > cpu0: MSR_NHM_SNB_PKG_CST_CFG_CTL: 0x06000403 (demote-C3, demote-C1=
,
> > UNlocked: pkg-cstate-limit=3D3: pc6)
> >=20
> > As described in the Intel Software Developer's Manual,
> > this MSR, MSR_PKG_CST_CONFIG_CONTROL has a package C-state limit fi=
eld.
> > Above it limits the hardware to PC6, but could easily be set to PC3=
=2E
> >=20
> > In one of the examples above, the register was locked by the BIOS,
> > preventing Linux from modifying it, in the 2nd example, it is unloc=
ked.
> >=20
> > if we limited the package to PC3 here, then Linux would still choos=
e CC6,
> > but when all the cores entered CC6, the deepest the package would
> > go would be PC3.
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
