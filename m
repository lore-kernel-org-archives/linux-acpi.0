From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/radeon: add new AMD ACPI header and update relevant
	code
Date: Thu, 26 Jul 2012 15:42:26 -0400
Message-ID: <CADnq5_NY8hX3g7-gvahHvDM__2xk_s5ZU7zgLhyY0QQvJon6cA@mail.gmail.com>
References: <1343237889-5220-1-git-send-email-alexdeucher@gmail.com>
	<20120726125838.GA28853@growl>
	<CADnq5_Nr8S+kzdKVq9=VL9BVK+4eFeX0egs-rkiv882MAm3bow@mail.gmail.com>
	<20120726193346.GA11288@growl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <20120726193346.GA11288@growl>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, dri-devel@lists.freedesktop.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Jul 26, 2012 at 3:33 PM, Luca Tettamanti <kronos.it@gmail.com> wrote:
> On Thu, Jul 26, 2012 at 11:35:25AM -0400, Alex Deucher wrote:
>> On Thu, Jul 26, 2012 at 8:58 AM, Luca Tettamanti <kronos.it@gmail.com> wrote:
>> > The other missing bit is how to actually change the brightness... Alex,
>> > do you know what registers to poke?
>>
>> You need to check if the GPU controls the backlight or the system
>> does.  I think the attached patches should point you in the right
>> direction.
>
> Yep :)
>
> 0050:  ATOM_FIRMWARE_CAPABILITY_ACCESS usFirmwareCapability :
>   0050:  (union) ATOM_FIRMWARE_CAPABILITY sbfAccess          :
>     USHORT GPUControlsBL:1                              = 0x0001     (1)
>
> The panel is using the INTERNAL_UNIPHY encoder, and I see the
> UNIPHYTransmitterControl command table.
>
> Interaction with video.ko is still a bit messy...
>
> Do you already have code for handling the notifications? I'll work on it
> in the weekend otherwise ;)

I don't have patches for that.  Please feel free to work on it :)

Thanks,

Alex
