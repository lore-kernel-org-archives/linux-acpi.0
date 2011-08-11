From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pnp: replace deprecated __check_region to request_region
Date: Thu, 11 Aug 2011 15:11:10 -0600
Message-ID: <CAErSpo6Fh+zTMiSG+mjkNuA03cCEK7bej9y2oX+HfsScSYGFsw@mail.gmail.com>
References: <1312817901-5313-1-git-send-email-wangshaoyan.pt@taobao.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1312817901-5313-1-git-send-email-wangshaoyan.pt@taobao.com>
Sender: linux-kernel-owner@vger.kernel.org
To: stufever@gmail.com
Cc: linux-kernel@vger.kernel.org, abelay@mit.edu, Wang Shaoyan <wangshaoyan.pt@taobao.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Aug 8, 2011 at 9:38 AM,  <stufever@gmail.com> wrote:
> From: Wang Shaoyan <wangshaoyan.pt@taobao.com>
>
> The function __check_region is deprecated, use proper function reques=
t_region to replace it.
>
> Signed-off-by: Wang Shaoyan <wangshaoyan.pt@taobao.com>
> ---
> =A0drivers/pnp/resource.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/pnp/resource.c b/drivers/pnp/resource.c
> index b0ecacb..b1d8cae 100644
> --- a/drivers/pnp/resource.c
> +++ b/drivers/pnp/resource.c
> @@ -179,7 +179,7 @@ int pnp_check_port(struct pnp_dev *dev, struct re=
source *res)
> =A0 =A0 =A0 =A0/* check if the resource is already in use, skip if th=
e
> =A0 =A0 =A0 =A0 * device is active because it itself may be in use */
> =A0 =A0 =A0 =A0if (!dev->active) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (__check_region(&ioport_resource, *p=
ort, length(port, end)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!request_region(*port, length(port,=
 end), "pnp"))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A0 =A0 =A0}
>
> --

We usually funnel PNP stuff through the linux-acpi@vger.kernel.org
mailing list, so I added a cc: to it.

request_region() is not a drop-in replacement for __check_region()
because __check_region() releases the resource before it returns
success.  I agree that it would be good to get rid of
__check_region(), but I think it's a little more work than just this.

I suppose you could just do the release_resource() in
pnp_check_port(), after request_region() was successful.  But the
problem with __check_region() is that it's racy, and moving the
release_resource() into pnp_check_port() doesn't remove the race.  It
just moves the problem from __check_region() (which is easy to grep
for) into PNP (where it's not so obvious).

Part of the problem is that the PNP core doesn't actually request any
of the resources used by PNP devices.  The PCI core *does* reserve
resources, independent of any drivers, and it would certainly be
reasonable to expect the PNP core to do the same, but it doesn't.
This is mostly because there are a bunch of hardcoded legacy resources
that conflict with PNP devices, and we haven't figured out a good way
to resolve the conflicts.

Bjorn
