From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v5 01/14] x86/boot: enumerate documentation for the x86
 hardware_subarch
Date: Wed, 13 Apr 2016 17:17:20 +0200
Message-ID: <20160413151720.GT1990@wotan.suse.de>
References: <1460158825-13117-1-git-send-email-mcgrof@kernel.org>
 <1460158825-13117-2-git-send-email-mcgrof@kernel.org>
 <20160413080132.GA9697@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160413080132.GA9697@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au, x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, andriy.shevchenko@linux.intel.com, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, kozerkov@parallels.com, josh@joshtriplett.org, joro@8bytes.org, tiwai@suse.de
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 13, 2016 at 10:01:32AM +0200, Ingo Molnar wrote:
> > diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> > index 329254373479..bf9fea2f4591 100644
> > --- a/arch/x86/include/uapi/asm/bootparam.h
> > +++ b/arch/x86/include/uapi/asm/bootparam.h
> > @@ -157,7 +157,42 @@ struct boot_params {
> >  	__u8  _pad9[276];				/* 0xeec */
> >  } __attribute__((packed));
> >  
> > -enum {
> > +/**
> > + * enum x86_hardware_subarch - x86 hardware subarchitecture
> 
> Could you add some prominent warning here, like:
> 
> > + * WARNING: the 'x86 subarch flag' is only used for legacy hacks, for platform
> > + *          features that are not easily enumerated or discoverable. You should
> > + *          not ever use this for new features.

With pleasure, added.

  Luis
