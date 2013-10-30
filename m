From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 0/4] Fix Win8 backlight issue
Date: Wed, 30 Oct 2013 01:56:04 +0100
Message-ID: <3079224.ztPUEhjm69@vostro.rjw.lan>
References: <1381498066-16011-1-git-send-email-aaron.lu@intel.com>
	<2140073.U60XyxRqVZ@vostro.rjw.lan> <1383093613.20804.4.camel@x230>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1383093613.20804.4.camel@x230>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces@lists.freedesktop.org
Errors-To: intel-gfx-bounces@lists.freedesktop.org
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: "james@albanarts.com" <james@albanarts.com>, "bitbucket@online.de" <bitbucket@online.de>, "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "hmh@hmh.eng.br" <hmh@hmh.eng.br>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "kvalo@adurom.com" <kvalo@adurom.com>, "corsac@debian.org" <corsac@debian.org>, "Martin@lichtvoll.de" <Martin@lichtvoll.de>, "joeyli.kernel@gmail.com" <joeyli.kernel@gmail.com>, "ben@bjencks.net" <ben@bjencks.net>, "jrg.otte@gmail.com" <jrg.otte@gmail.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "jplatte@naasa.net" <jplatte@naasa.net>, "seth.forshee@canonical.com" <seth.forshee@canonical.com>, "i.gnatenko.brain@gmail.com" <i.gnatenko.brain@gmail.com>, mik
List-Id: linux-acpi@vger.kernel.org

On Wednesday, October 30, 2013 12:40:13 AM Matthew Garrett wrote:
> On Wed, 2013-10-16 at 01:33 +0200, Rafael J. Wysocki wrote:
> 
> > Since the next step will be to introduce a list of systems that need
> > video.use_native_backlight=1 *and* don't break in that configuration, I don't
> > see much point adding another Kconfig option for the default.
> 
> I'd still really prefer not to add such a list, because it almost
> inevitably means that we'll never fix this problem properly.

We have this list in blacklist.c anyway.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
