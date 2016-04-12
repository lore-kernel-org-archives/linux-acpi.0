From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [Xen-devel] [PATCH v5 04/14] x86/rtc: replace paravirt rtc check
 with platform legacy quirk
Date: Tue, 12 Apr 2016 22:50:56 +0200
Message-ID: <20160412205056.GJ1990@wotan.suse.de>
References: <1460158825-13117-1-git-send-email-mcgrof@kernel.org>
 <1460158825-13117-5-git-send-email-mcgrof@kernel.org>
 <570B492B.80608@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <570B492B.80608@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juergen Gross <jgross@suse.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au, kozerkov@parallels.com, matt@codeblueprint.co.uk, lv.zheng@intel.com, xen-devel@lists.xensource.com, joro@8bytes.org, x86@kernel.org, robert.moore@intel.com, linux-acpi@vger.kernel.org, glin@suse.com, lenb@kernel.org, josh@joshtriplett.org, jlee@suse.com, lguest@lists.ozlabs.org, boris.ostrovsky@oracle.com, andriy.shevchenko@linux.intel.com, toshi.kani@hp.com, andrew.cooper3@citrix.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, luto@amacapital.net, david.vrabel@citrix.com, tiwai@suse.de
List-Id: linux-acpi@vger.kernel.org

On Mon, Apr 11, 2016 at 08:50:19AM +0200, Juergen Gross wrote:
> On 09/04/16 01:40, Luis R. Rodriguez wrote:
> > We have 4 types of x86 platforms that disable RTC:
> > 
> >   * Intel MID
> >   * Lguest - uses paravirt
> >   * Xen dom-U - uses paravirt
> >   * x86 on legacy systems annotated with an ACPI legacy flag
> > 
> > We can consolidate all of these into a platform specific legacy
> > quirk set early in boot through i386_start_kernel() and through
> > x86_64_start_reservations(). This deals with the RTC quirks which
> > we can rely on through the hardware subarch, the ACPI check can
> > be dealt with separately.
> > 
> > For Xen things are bit more complex given that the @X86_SUBARCH_XEN
> > x86_hardware_subarch is shared on for Xen which uses the PV path for
> > both domU and dom0. Since the semantics for differentiating between
> > the two are Xen specific we provide a platform helper to help override
> > default legacy features -- x86_platform.set_legacy_features(). Use
> > of this helper is highly discouraged, its only purpose should be
> > to account for the lack of semantics available within your given
> > x86_hardware_subarch.
> > 
> > As per 0-day, this bumps the vmlinux size using i386-tinyconfig as
> > follows:
> > 
> > TOTAL   TEXT   init.text    x86_early_init_platform_quirks()
> > +70     +62    +62          +43
> > 
> > Only 8 bytes overhead total, as the main increase in size is
> > all removed via __init.
> 
> I think this could be even less (see comment below).

Indeed.

> 
> > 
> > v2: split the subarch check from the ACPI check, clarify
> >     on the ACPI change commit log why ordering works
> > v3: add x86_platform.set_legacy_features() to account for dom0,
> >     add also size impact on vmlinux as per 0-day report
> 
> You missed the v5 changes here.


Sorry this was a mismatch, the v3 notes are the v5 notes, the
discrepancy between this and the subject was that the patches
have changed over time to be split out on their own and so 
iterations have been meshed / split, etc.. I'll just
update the accounting to match the subject next.

In next replies it would really help if you trim your review on
patches by removing context of the e-mail for hunks / file without
feedback, and only keep the file name / hunk for which you are
commenting on.

For instance:

> > diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
> > index 40487f1ecb4c..e066fcf87c3d 100644
> > --- a/arch/x86/xen/enlighten.c
> > +++ b/arch/x86/xen/enlighten.c
> > @@ -1192,7 +1192,6 @@ static const struct pv_info xen_info __initconst = {
> >  #ifdef CONFIG_X86_64
> >  	.extra_user_64bit_cs = FLAT_USER_CS64,
> >  #endif
> > -	.features = 0,
> >  	.name = "Xen",
> >  };
> >  
> > @@ -1505,6 +1504,11 @@ static void __init xen_pvh_early_guest_init(void)
> >  }
> >  #endif    /* CONFIG_XEN_PVH */
> >  
> > +static void xen_dom0_set_legacy_features(void)
> 
> Can't you make this __init ?

Indeed, will change.

  Luis
