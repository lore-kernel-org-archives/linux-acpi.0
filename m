From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH] ACPI / video: Use native backlight control
	interface by default
Date: Thu, 5 Dec 2013 08:50:21 +0100
Message-ID: <CAKMK7uG14CK+PO4RDzh+GKXotNuSead7-sN83SujK826jgt5iw@mail.gmail.com>
References: <1386209037-31349-1-git-send-email-acelan.kao@canonical.com>
	<20131205023237.GA23671@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20131205023237.GA23671@srcf.ucam.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces@lists.freedesktop.org
Errors-To: intel-gfx-bounces@lists.freedesktop.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Dec 5, 2013 at 3:32 AM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> We had problems with the Intel backlight driver the last time we tried
> this, so let's push this through their tree for testing first? Cc:ed
> intel-gfx and Daniel Vetter.

Makes sense imo. Or if I just get a branch with just those patches (it
can rebase, I don't really care) I could  pull it into our
drm-intel-nightly integration tree, which is what everyone is testing
anyway.
-Daniel

>
>
> On Thu, Dec 05, 2013 at 10:03:57AM +0800, AceLan Kao wrote:
>> The native/vendor backlight control interface is hardly fail to control the
>> brightness, and we had encountered many backlight issues result from the broken
>> ACPI backlight interface, so I think we should promote the native backlight
>> control interface and use it by default.
>>
>> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
>> ---
>>  drivers/acpi/video.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
>> index 995e91b..b3032f8 100644
>> --- a/drivers/acpi/video.c
>> +++ b/drivers/acpi/video.c
>> @@ -85,7 +85,7 @@ module_param(allow_duplicates, bool, 0644);
>>   * For Windows 8 systems: if set ture and the GPU driver has
>>   * registered a backlight interface, skip registering ACPI video's.
>>   */
>> -static bool use_native_backlight = false;
>> +static bool use_native_backlight = true;
>>  module_param(use_native_backlight, bool, 0644);
>>
>>  static int register_count;
>> --
>> 1.8.3.2
>>
>>
> --
> Matthew Garrett | mjg59@srcf.ucam.org



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
