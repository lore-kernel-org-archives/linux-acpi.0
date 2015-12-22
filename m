From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 0/5] acpi-video and platform/x86 driver fixes
Date: Tue, 22 Dec 2015 13:00:59 -0800
Message-ID: <20151222210059.GP7244@malice.jf.intel.com>
References: <1450807792-4980-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450807792-4980-1-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Corentin Chary <corentin.chary@gmail.com>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, ibm-acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 22, 2015 at 07:09:47PM +0100, Hans de Goede wrote:
> Hi All,
> 
> This patch-set is the result of the discussion surrounding the
> backlight issues on the Dell Vostro V131. The first 3 patches
> cleanup how some platform/x86 drivers detect if acpi-video
> is handling brightness key presses and that they should
> not report duplicate events. This is a cleanup which I wanted
> to do for a while already and the Vostro V131 fix actually
> benefits from this.
> 
> The last 2 patches together actually fix the issues on the
> Vostro V131. Since the 2 platform patches in this set depend
> on an acpi patch, I believe that it would be best if this
> entire set gets merged via the acpi tree with acks
> from the platform driver maintainer.

Agreed on the path. For this situation, the addition of the module parameter
will facilitate identifying similarly broken paltforms to the Vostro V131, and
provide users with a temporary solution until the DMI match can be added. Very
practical.

I have no objection to the changes in platform-drivers-x86.

Reviewed-by: Darren Hart <dvhart@linux.intel.com>

-- 
Darren Hart
Intel Open Source Technology Center
