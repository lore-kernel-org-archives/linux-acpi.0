From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] ACPI / PMIC: xpower: fix IOSF_MBI dependency
Date: Mon, 5 Nov 2018 15:33:01 +0200
Message-ID: <20181105133301.GE10650@smile.fi.intel.com>
References: <20181102110653.118257-1-arnd@arndb.de>
 <20181102151644.GB10650@smile.fi.intel.com>
 <CAK8P3a2ESTVLG3q0LgDmjqa_LbYhLCeqYW3Jod6WUCh2fwFOZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a2ESTVLG3q0LgDmjqa_LbYhLCeqYW3Jod6WUCh2fwFOZg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 02, 2018 at 11:07:34PM +0100, Arnd Bergmann wrote:
> On 11/2/18, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Nov 02, 2018 at 12:06:43PM +0100, Arnd Bergmann wrote:

> >> -	depends on MFD_AXP20X_I2C && IOSF_MBI
> >> +	depends on MFD_AXP20X_I2C && IOSF_MBI=y
> >
> > To me sounds like
> >
> > select IOSF_MBI would be more appropriate here.
> 
> It looks like we have a mix of the two two, with most drivers
> using 'select' and only a few ones using 'depends on'. Mixing
> the two often leads to trouble, especially for user-visible
> symbols.
> 
> Making it a hidden symbol that is always selected is probably
> fine, but then every driver selecting it must also use 'depends
> on X86 && PCI'.

I doubt every is a correct word here. Whenever driver uses IOSF_MBI it implies
X86 and PCI (or should have those dependencies in mind already).

But I agree that hide it and select as a library would make more sense than the
current state of affairs.

-- 
With Best Regards,
Andy Shevchenko
