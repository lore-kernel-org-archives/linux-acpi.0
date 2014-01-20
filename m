From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH v3] ACPI / video: Add systems that should
 favor native backlight interface
Date: Mon, 20 Jan 2014 16:12:37 +0800
Message-ID: <52DCDA75.2000108@intel.com>
References: <1390053249-18919-1-git-send-email-i.gnatenko.brain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1390053249-18919-1-git-send-email-i.gnatenko.brain@gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Igor Gnatenko <i.gnatenko.brain@gmail.com>, linux-acpi@vger.kernel.org
Cc: James Hogan <james@albanarts.com>, Mike Galbraith <bitbucket@online.de>, Felipe Contreras <felipe.contreras@gmail.com>, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Matthew Garrett <matthew.garrett@nebula.com>, Kalle Valo <kvalo@adurom.com>, Yves-Alexis Perez <corsac@debian.org>, Martin Steigerwald <Martin@lichtvoll.de>, Lee Chun-Yi <joeyli.kernel@gmail.com>, Ben Jencks <ben@bjencks.net>, =?UTF-8?B?SsO2cmcgT3R0ZQ==?= <jrg.otte@gmail.com>, intel-gfx@lists.freedesktop.org, Kevin Smith <thirdwiggin@gmail.com>, Peter Weber <bugs@ttyhoney.com>, Joerg Platte <jplatte@naasa.net>, Seth Forshee <seth.forshee@canonical.com>, Lennart Poettering <lennart@poettering.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Theodore Tso <tytso@mit.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.ke
List-Id: linux-acpi@vger.kernel.org

Hi Igor,

On 01/18/2014 09:54 PM, Igor Gnatenko wrote:
> From: Aaron Lu <aaron.lu@intel.com>
> 
> Some system's ACPI video backlight control interface is broken and the
> native backlight control interface should be used by default. This patch
> sets the use_native_backlight parameter to true for those systems so
> that video backlight control interface will not be created. To be
> specific, the ThinkPad T430s/X230/X1 Carbon, Lenovo Yoga 13, Dell
> Inspiron 7520, Acer Aspire 5733Z and HP ProBook 4340s are added here,
> if they appear in some other DMI table before, they are removed from there.
> 
> Note that the user specified kernel cmdline option will always have the
> highest priority, i.e. if use_native_backlight=0 is specified and the
> system is in the DMI table, the video module will not skip registering
> backlight interface for it.
> 
> Thinkpad T430s:
> Reported-by: Theodore Tso <tytso@mit.edu>
> Reported-and-tested-by: Peter Weber <bugs@ttyhoney.com>
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=51231
> Thinkpad X230:
> Reported-and-tested-by: Igor Gnatenko <i.gnatenko.brain@gmail.com>
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=51231
> ThinkPad X1 Carbon:
> Reported-and-tested-by: Igor Gnatenko <i.gnatenko.brain@gmail.com>
> Lenovo Yoga 13:
> Reported-by: Lennart Poettering <lennart@poettering.net>
> Reported-and-tested-by: Kevin Smith <thirdwiggin@gmail.com>
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=63811
> Dell Inspiron 7520:
> Reported-by: Rinat Ibragimov <ibragimovrinat@mail.ru>
> Acer Aspire 5733Z:
> Reported-by: <sov.info@mail.ru>
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=62941
> HP ProBook 4340s:
> Reported-and-tested-by: Vladimir Sherenkov <a_12300@mail.ru>
> Reference: http://redmine.russianfedora.pro/issues/1258
> 
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> Signed-off-by: Igor Gnatenko <i.gnatenko.brain@gmail.com>

Thanks for updating this patch.

In the meantime, I plan to make some small modifications to this patch
in next revision:
1 remove the win8 OSI check, I've seen win7 laptops that also needs to
  have only the GPU interface left and checking win8 doesn't make much
  sense now;
2 add more entries for laptops that appeared in bugzilla recently.
