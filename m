From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / video: driver must be registered before checking for keypresses
Date: Tue, 05 Jan 2016 13:51:17 +0100
Message-ID: <5472545.fTVKdflT9H@vostro.rjw.lan>
References: <1451946148-24948-1-git-send-email-adrien+dev@schischi.me> <568BAC7A.5040907@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <568BAC7A.5040907@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Adrien Schildknecht <adrien+dev@schischi.me>, rui.zhang@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, jmmahler@gmail.com, ibm-acpi@hmh.eng.br
List-Id: linux-acpi@vger.kernel.org

On Tuesday, January 05, 2016 12:43:54 PM Hans de Goede wrote:
> Hi,
> 
> On 04-01-16 23:22, Adrien Schildknecht wrote:
> > acpi_video_handles_brightness_key_presses() may use an uninitialized mutex.
> > The error has been reported by lockdep: DEBUG_LOCKS_WARN_ON(l->magic != l).
> > The function assumes that the video driver has been registered before being
> > called. As explained in the comment of acpi_video_init(), the registration
> > of the video class may be defered and thus may not take place in the init
> > function of the module.
> >
> > Use completion mechanisms to make sure that
> > acpi_video_handles_brightness_key_presses() wait for the completion of
> > acpi_video_register() before using the mutex.
> > Also get rid of register_count since task completion can replace it.
> >
> > Signed-off-by: Adrien Schildknecht <adrien+dev@schischi.me>
> 
> Thanks for the fix, my first instinct was that there should be an easier
> fix, but thinking more about it this and how this function is used
> in thinkpad_acpi. this is indeed the correct way to fix this:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Rafael, can you please add this fix to acpi-next ?

I will, thanks!

Rafael
