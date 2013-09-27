From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 0/4] Fix Win8 backlight issue
Date: Fri, 27 Sep 2013 14:02:27 +0300
Message-ID: <20130927110227.GD28875@intel.com>
References: <1380016052-15315-1-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <1380016052-15315-1-git-send-email-aaron.lu@intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: James Hogan <james@albanarts.com>, Martin Steigerwald <Martin@lichtvoll.de>, Felipe Contreras <felipe.contreras@gmail.com>, dri-devel@lists.freedesktop.org, Matthew Garrett <matthew.garrett@nebula.com>, Mike Galbraith <bitbucket@online.de>, Kalle Valo <kvalo@adurom.com>, Yves-Alexis Perez <corsac@debian.org>, linux-acpi@vger.kernel.org, Lee Chun-Yi <joeyli.kernel@gmail.com>, Ben Jencks <ben@bjencks.net>, =?iso-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>, intel-gfx@lists.freedesktop.org, Joerg Platte <jplatte@naasa.net>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, "Rafael J. Wysocki" <rjw@sisk.pl>, Seth Forshee <seth.forshee@canonical.com>, Igor Gnatenko <i.gnatenko.brain@gmail.com>, linux-kernel@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>
List-Id: linux-acpi@vger.kernel.org

On Tue, Sep 24, 2013 at 05:47:28PM +0800, Aaron Lu wrote:
> v3:
> 1 Add a new patch 4/4 to fix some problems in thinkpad-acpi module;
> 2 Remove unnecessary function acpi_video_unregister introduced in
>   patch 2/3 as pointed out by Jani Nikula.
> 
> v2:
> v1 has the subject of "Rework ACPI video driver" and is posted here:
> http://lkml.org/lkml/2013/9/9/74
> Since the objective is really to fix Win8 backlight issues, I changed
> the subject in this version, sorry about that.
> 
> This patchset has three patches, the first introduced a new API named
> backlight_device_registered in backlight layer that can be used for
> backlight interface provider module to check if a specific type backlight
> interface has been registered, see changelog for patch 1/3 for details.
> Then patch 2/3 does the cleanup to sepeate the backlight control and
> event delivery functionality in the ACPI video module and patch 3/3
> solves some Win8 backlight control problems by avoiding register ACPI
> video's backlight interface if:
> 1 Kernel cmdline option acpi_backlight=video is not given;
> 2 This is a Win8 system;
> 3 Native backlight control interface exists.
> 
> Technically, patch 2/3 is not required to fix the issue here. So if you
> think it is not necessary, I can remove it from the series.
> 
> Aaron Lu (4):
>   backlight: introduce backlight_device_registered
>   ACPI / video: seperate backlight control and event interface
>   ACPI / video: Do not register backlight if win8 and native interface
>     exists
>   thinkpad-acpi: fix handle locate for video and query of _BCL
> 
>  drivers/acpi/internal.h              |   5 +-
>  drivers/acpi/video.c                 | 442 ++++++++++++++++++++---------------
>  drivers/acpi/video_detect.c          |  14 +-
>  drivers/platform/x86/thinkpad_acpi.c |  31 ++-
>  drivers/video/backlight/backlight.c  |  31 +++
>  include/acpi/video.h                 |   2 +
>  include/linux/backlight.h            |   4 +
>  7 files changed, 324 insertions(+), 205 deletions(-)

Just tested this series on my HP revolve 810 and this fixes the backlight
issue it had :)

Feel free to add my,

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
