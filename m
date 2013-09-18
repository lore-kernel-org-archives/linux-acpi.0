From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH v2 0/3] Fix Win8 backlight issue
Date: Wed, 18 Sep 2013 09:03:49 +0800
Message-ID: <5238FBF5.8080405@intel.com>
References: <1379409796-29350-1-git-send-email-aaron.lu@intel.com>
	<1379424853.3348.1.camel@ThinkPad-X230.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1379424853.3348.1.camel@ThinkPad-X230.localdomain>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Igor Gnatenko <i.gnatenko.brain@gmail.com>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, Felipe Contreras <felipe.contreras@gmail.com>, Seth Forshee <seth.forshee@canonical.com>, intel-gfx@lists.freedesktop.org, Yves-Alexis Perez <corsac@debian.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Lee Chun-Yi <joeyli.kernel@gmail.com>, Richard Purdie <rpurdie@rpsys.net>
List-Id: linux-acpi@vger.kernel.org

On 09/17/2013 09:34 PM, Igor Gnatenko wrote:
> On Tue, 2013-09-17 at 17:23 +0800, Aaron Lu wrote:
>> v1 has the subject of "Rework ACPI video driver" and is posted here:
>> http://lkml.org/lkml/2013/9/9/74
>> Since the objective is really to fix Win8 backlight issues, I changed
>> the subject in this version, sorry about that.
>>
>> This patchset has three patches, the first introduced a new API named
>> backlight_device_registered in backlight layer that can be used for
>> backlight interface provider module to check if a specific type backlight
>> interface has been registered, see changelog for patch 1/3 for details.
>> Then patch 2/3 does the cleanup to sepeate the backlight control and
>> event delivery functionality in the ACPI video module and patch 3/3
>> solves some Win8 backlight control problems by avoiding register ACPI
>> video's backlight interface if:
>> 1 Kernel cmdline option acpi_backlight=video is not given;
>> 2 This is a Win8 system;
>> 3 Native backlight control interface exists.
>>
>> Technically, patch 2/3 is not required to fix the issue here. So if you
>> think it is not necessary, I can remove it from the series.
>>
>> Apply on top of v3.12-rc1.
>>
>> Aaron Lu (3):
>>   backlight: introduce backlight_device_registered
>>   ACPI / video: seperate backlight control and event interface
>>   ACPI / video: Do not register backlight if win8 and native interface
>>     exists
>>
>>  drivers/acpi/internal.h             |   5 +-
>>  drivers/acpi/video.c                | 442 ++++++++++++++++++++----------------
>>  drivers/acpi/video_detect.c         |  14 +-
>>  drivers/video/backlight/backlight.c |  31 +++
>>  include/acpi/video.h                |   2 +
>>  include/linux/backlight.h           |   4 +
>>  6 files changed, 300 insertions(+), 198 deletions(-)
>>
> 
> Aaron, how about fix indicator on ThinkPads ?

Can you please describe the problem in detail, is it that when you
adjust brightness level through hotkey, there is no GUI indication?
Thanks.

-Aaron
