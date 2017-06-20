From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2] platform/x86: wmi-bmof: New driver to expose embedded
 Binary WMI MOF metadata
Date: Tue, 20 Jun 2017 14:12:40 +0200
Message-ID: <20170620121240.GL32387@pali>
References: <cd020900567e5c26af29e0735a3945a855d26a30.1496718529.git.dvhart@infradead.org>
 <201706191807.42574@pali>
 <074e9d5668864a81b255df178ed28814@ausx13mpc120.AMER.DELL.COM>
 <201706191819.37016@pali>
 <CALCETrXKLLfBr_pA45u+-VB_cGda6MrehQoSfoHQSn4Dgvgo7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrXKLLfBr_pA45u+-VB_cGda6MrehQoSfoHQSn4Dgvgo7g@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Mario.Limonciello@dell.com, Andrew Lutomirski <luto@kernel.org>, platform-driver-x86@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Monday 19 June 2017 09:23:45 Andy Lutomirski wrote:
> On Mon, Jun 19, 2017 at 9:19 AM, Pali Rohár <pali.rohar@gmail.com> wrote:
> > On Monday 19 June 2017 18:13:13 Mario.Limonciello@dell.com wrote:
> >> > -----Original Message-----
> >> > From: Pali Rohár [mailto:pali.rohar@gmail.com]
> >> > Sent: Monday, June 19, 2017 11:08 AM
> >> > To: Andy Lutomirski <luto@kernel.org>
> >> > Cc: platform-driver-x86@vger.kernel.org; Andy Shevchenko
> >> > <andriy.shevchenko@linux.intel.com>; Andy Lutomirski
> >> > <luto@amacapital.net>; Limonciello, Mario
> >> > <Mario_Limonciello@Dell.com>; Rafael Wysocki <rjw@rjwysocki.net>;
> >> > linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org Subject:
> >> > Re: [PATCH v2] platform/x86: wmi-bmof: New driver to expose
> >> > embedded Binary WMI MOF metadata
> >> >
> >> > On Tuesday 06 June 2017 05:16:44 Andy Lutomirski wrote:
> >> > > Many laptops (and maybe servers?) have embedded WMI Binary MOF
> >> > > metadata. We do not yet have open-source tools for processing the
> >> > >
> >> > > data, although one is in the works thanks to Pali:
> >> > >   https://github.com/pali/bmfdec
> >> > >
> >> > > There is currently no interface to get the data in the first
> >> > > place. By exposing it, we facilitate the development of new
> >> > > tools.
> >> > >
> >> > > Signed-off-by: Andy Lutomirski <luto@kernel.org>
> >> > > Cc: Andy Lutomirski <luto@amacapital.net>
> >> > > Cc: Mario Limonciello <mario_limonciello@dell.com>
> >> > > Cc: Pali Rohár <pali.rohar@gmail.com>
> >> > > Cc: linux-kernel@vger.kernel.org
> >> > > Cc: platform-driver-x86@vger.kernel.org
> >> > > Cc: linux-acpi@vger.kernel.org
> >> > > [dvhart: make sysfs mof binary read only, fixup comment block
> >> > > format] [dvhart: use bmof terminology and dev_err instead of
> >> > > dev_warn] Acked-by: Rafael J. Wysocki
> >> > > <rafael.j.wysocki@intel.com> Signed-off-by: Darren Hart (VMware)
> >> > > <dvhart@infradead.org> ---
> >> > >
> >> > > since-v1:
> >> > >  * address Pali's comments:
> >> > >    * update the cover letter for clarity and accuracy
> >> > >    * update mof->bmof and MOF to Binary MOF throughout the patch
> >> > >    * use dev_err instead of dev_warn in wmi_bmof_probe
> >> > >
> >> > >  drivers/platform/x86/Kconfig    |  12 ++++
> >> > >  drivers/platform/x86/Makefile   |   1 +
> >> > >  drivers/platform/x86/wmi-bmof.c | 125
> >> >
> >> > Another suggestion (unrelated to this patch): For working with
> >> > ACPI-WMI, this binary MOF buffer is not enough. It is needed also
> >> > content of _WDG buffer. What about exporting it too via sysfs?
> >> > Probably not part of of wmi-bmof driver, but wmi driver itself.
> >>
> >> I think this depends upon how the userspace access to WMI methods
> >> gets implemented, no?  If userpsace access to WMI methods show up as
> >> /dev/wmi-$GUID-$INSTANCE and those internally to the kernel map to
> >> the proper ASL methods for example, what you get from wmi-bmof
> >> should be enough shouldn't it?
> >
> > Ok. Such interface for userspace application could be enough.
> >
> > But for debugging purposes or writing new WMI driver it is needed to
> > have both _WDG + BMOF.
> 
> With the busification patches applied, all the _WDG data should be
> available in sysfs in parsed form.  I have no particular objection to
> adding a new sysfs for debugfs file to give the raw binary blob, but
> I'm not sure it's needed.

I'm thinking about writing userspace tool which print information
mapping from MOF namespace/class/method name to ACPI method. Ideally if
it could parse all WMI data on its own and not depends on new parsed
/sys/ tree structure. From _WDG it is needed to know ACPI ID or WMI
event IDs.

-- 
Pali Rohár
pali.rohar@gmail.com
