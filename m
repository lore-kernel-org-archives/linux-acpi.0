From: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Subject: Re: [PATCH 08/14] wmi: Probe data objects for read and write
 capabilities
Date: Thu, 12 Jan 2017 06:01:59 +0100
Message-ID: <20170112050159.GA4072@kmp-mobile.hq.kempniu.pl>
References: <cover.1448931782.git.luto@kernel.org>
 <6027f0563e82e3ca5265c6b29777636a9b8dc244.1448931782.git.luto@kernel.org>
 <20160116131111.GB7816@eudyptula.hq.kempniu.pl>
 <CALCETrUAyseBY-PvU2szRr9BcBXu-whEbNrKNN6x=yAjJuXVYQ@mail.gmail.com>
 <20170110055606.GA1535@kmp-mobile.hq.kempniu.pl>
 <CALCETrU0PVUK7dUzNfv3BbPPrrGWhm+akBAunfks-JkOxqzJSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrU0PVUK7dUzNfv3BbPPrrGWhm+akBAunfks-JkOxqzJSg@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>, Darren Hart <dvhart@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
List-Id: linux-acpi@vger.kernel.org

> On Mon, Jan 9, 2017 at 9:56 PM, Michał Kępień <kernel@kempniu.pl> wrote:
> >> On Sat, Jan 16, 2016 at 5:11 AM, Michał Kępień <kernel@kempniu.pl> wrote:
> >> >> My laptop has one RW data object, one RO data object, and one
> >> >> totally inaccessible data object.  Check for the existence of the
> >> >> accessor methods and report in sysfs.
> >> >>
> >> >> The docs also permit WQxx getters for single-instance objects to
> >> >> take no parameters.  Probe for that as well to avoid ACPICA warnings
> >> >> about mismatched signatures.
> >> >>
> >> >> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> >> >> ---
> >> >>  drivers/platform/x86/wmi.c | 94 ++++++++++++++++++++++++++++++++++++++++++++--
> >> >>  include/linux/wmi.h        |  6 +++
> >> >>  2 files changed, 96 insertions(+), 4 deletions(-)
> >> >>
> >> >> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> >> >> index 5571ae7354a1..49be61207c4a 100644
> >> >> --- a/drivers/platform/x86/wmi.c
> >> >> +++ b/drivers/platform/x86/wmi.c
> >> >> @@ -66,6 +66,8 @@ struct wmi_block {
> >> >>       struct acpi_device *acpi_device;
> >> >>       wmi_notify_handler handler;
> >> >>       void *handler_data;
> >> >> +
> >> >> +     bool read_takes_no_args;        /* only defined if readable */
> >> >>  };
> >> >>
> >> >>
> >> >> @@ -216,6 +218,25 @@ static bool find_guid(const char *guid_string, struct wmi_block **out)
> >> >>       return false;
> >> >>  }
> >> >>
> >> >> +static int get_subobj_info(acpi_handle handle, const char *pathname,
> >> >> +                        struct acpi_device_info *info)
> >> >> +{
> >> >> +     acpi_handle subobj_handle;
> >> >> +     acpi_status status;
> >> >> +
> >> >> +     status = acpi_get_handle(handle, (char *)pathname, &subobj_handle);
> >> >> +     if (status == AE_NOT_FOUND)
> >> >> +             return -ENOENT;
> >> >> +     else if (ACPI_FAILURE(status))
> >> >> +             return -EIO;
> >> >> +
> >> >> +     status = acpi_get_object_info(subobj_handle, &info);
> >> >
> >> > acpi_get_object_info() allocates the returned buffer itself.  The latter
> >> > should then subsequently be freed by the caller.  One solution is to
> >> > change get_subobj_info() so that it takes a struct acpi_device_info **
> >> > as an argument, which should then be passed to acpi_get_object_info().
> >> > See also below.
> >>
> >> I have an updated version of this patch in my queue.  I'll try to send
> >> it early next week.
> >
> > Hi Andy,
> >
> > Are you planning any further work on this patch series (originally
> > posted in December 2015)?  It seems to be a valuable cleanup.
> 
> I have a tree in which the patches are sitting and I've kept them
> rebased, but I haven't had a chance to go through all the review
> comments and send them out.  Want to do it?

If you want me to take the rebased patches, fix the issues I can find
and resubmit as v2 with your name in From: then sure, I can give it a
shot once I find the time (might not be soon, though, but I guess there
is no rush).  If you had something else on your mind, please elaborate.

-- 
Best regards,
Michał Kępień
