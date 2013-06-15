From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: Re: [PATCH 3/3] i915: Don't provide ACPI backlight
 interface if firmware expects Windows 8
Date: Sat, 15 Jun 2013 01:38:05 +0000
Message-ID: <1371260284.523.2.camel@x230>
References: <1370818899-8595-1-git-send-email-matthew.garrett@nebula.com>
	<1370818899-8595-4-git-send-email-matthew.garrett@nebula.com>
	<51BABC6F.3050201@intel.com> <1371230988.2490.2.camel@x230>
	<51BBC2E1.9040401@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <51BBC2E1.9040401@intel.com>
Content-Language: en-US
Content-ID: <2861A50AFD728848B4788028958ADD4A@namprd05.prod.outlook.com>
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
Cc: Seth Forshee <seth.forshee@canonical.com>, "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Lee,
	Chun-Yi" <joeyli.kernel@gmail.com>, Alex Deucher <alexdeucher@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Aaron Lu <aaron.lwe@gmail.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, 2013-06-15 at 09:26 +0800, Aaron Lu wrote:
> On 06/15/2013 01:29 AM, Matthew Garrett wrote: 
> > How would that work with existing userspace?
> 
> User space tool will need to be updated to use this as stated in the
> gist page, I've patches for gsd-backlight-helper and xorg-x11-drv-intel,
> for others we can add I think if the priority based solution is deemed
> useful.

Right, that's not a great solution.

> > We shouldn't export interfaces if we don't expect them to work.
> 
> It's not easy to decide if they work or not sometimes, e.g. I came
> across a system that claims win8 in ACPI table and has an Intel GPU,
> while its ACPI video interface also works. With this patch, the working
> ACPI video interface is removed, while with the priority based solution,
> the GPU's interface priority gets higher, but the ACPI video interface
> still stays.

Well, Windows 8 will only use the ACPI backlight interface if the GPU
driver decides to, right? So the logic for deciding whether to remove
the ACPI backlight control or not should be left up to the GPU. There's
no harm in refusing to expose a working method if there's another
working method, but there is harm in exposing a broken one and expecting
userspace to know the difference.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
