From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: Re: [PATCH v5 0/4] Fix Win8 backlight issue
Date: Wed, 30 Oct 2013 00:40:13 +0000
Message-ID: <1383093613.20804.4.camel@x230>
References: <1381498066-16011-1-git-send-email-aaron.lu@intel.com>
	<2140073.U60XyxRqVZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <2140073.U60XyxRqVZ@vostro.rjw.lan>
Content-Language: en-US
Content-ID: <B62BC12587A7764CAABE97D06955885E@namprd05.prod.outlook.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces@lists.freedesktop.org
Errors-To: intel-gfx-bounces@lists.freedesktop.org
To: "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: "james@albanarts.com" <james@albanarts.com>, "bitbucket@online.de" <bitbucket@online.de>, "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "hmh@hmh.eng.br" <hmh@hmh.eng.br>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "kvalo@adurom.com" <kvalo@adurom.com>, "corsac@debian.org" <corsac@debian.org>, "Martin@lichtvoll.de" <Martin@lichtvoll.de>, "joeyli.kernel@gmail.com" <joeyli.kernel@gmail.com>, "ben@bjencks.net" <ben@bjencks.net>, "jrg.otte@gmail.com" <jrg.otte@gmail.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "jplatte@naasa.net" <jplatte@naasa.net>, "seth.forshee@canonical.com" <seth.forshee@canonical.com>, "i.gnatenko.brain@gmail.com" <i.gnatenko.brain@gmail.com>, mik
List-Id: linux-acpi@vger.kernel.org

On Wed, 2013-10-16 at 01:33 +0200, Rafael J. Wysocki wrote:

> Since the next step will be to introduce a list of systems that need
> video.use_native_backlight=1 *and* don't break in that configuration, I don't
> see much point adding another Kconfig option for the default.

I'd still really prefer not to add such a list, because it almost
inevitably means that we'll never fix this problem properly.

-- 
Matthew Garrett <matthew.garrett@nebula.com>
