From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 03/11] vga-switcheroo: make PCI dependency explicit
Date: Mon, 7 Jan 2019 11:53:46 +0100
Message-ID: <CAJZ5v0hJXSg5iAg4noFaut4AW3V1J0j4N1n1mq2zV3=4Ls5=uQ@mail.gmail.com>
References: <20181230195612.6657-1-okaya@kernel.org> <20181230195612.6657-4-okaya@kernel.org>
 <20190107103448.GG21184@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190107103448.GG21184@phenom.ffwll.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>, Linux-Next Mailing List <linux-next@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, David Airlie <airlied@linux.ie>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 7, 2019 at 11:34 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Sun, Dec 30, 2018 at 07:56:04PM +0000, Sinan Kaya wrote:
> > This driver depends on the PCI infrastructure but the dependency has not
> > been explicitly called out.
> >
> > Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > Reviewed-by: Lukas Wunner <lukas@wunner.de>
> > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> I'm assuming this goes in through the acpi tree, correct?

I'm going to pick it up.
