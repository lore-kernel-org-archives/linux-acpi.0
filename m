Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8188425CC57
	for <linux-acpi@vger.kernel.org>; Sun, 29 Mar 2026 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774801129; cv=pass; b=K8ND6b4KtgX3lMXVHD1nZxZ5JF7KyX/sszaeSlivUXO+SJn6kJjsV6sg9NZDcWEbKMKwEdbUKgKB82kK7nO3a9p8cA8z/gtAfdfRZP6ou2x4EwTw3oiarEdURrU8jlAvbrzfTwceYIQL+/fVLkBKoPK9+Wl11YxyLcGwcj3hSEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774801129; c=relaxed/simple;
	bh=xQqCvaSYvMDehLMpCAi2Exo2F9/DzAf4RUjSbu4AXqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urEwN+oI3BJBbSHW6mpVqgj33mKChyUC9g6kU11Chhe4r1GcPaWV9acPjGBenhbtshEpdW456kacsZ/nSQrhfjqtk/enNTGXCKEUlEYTZ3zVTTo34Un0JFTHVGfxFSuDZ2prg76E4TeRv66Vz52J1KffG3CJTi95FQG2OkeOIK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrzopNnu; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrzopNnu"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-467161c4a1cso1132940b6e.3
        for <linux-acpi@vger.kernel.org>; Sun, 29 Mar 2026 09:18:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774801127; cv=none;
        d=google.com; s=arc-20240605;
        b=WX1oWk6WsxMdhqOsXMaJOeNIQ6lwejAv1DNEeLwXpvFuey9gXjXO/F670MBVoHyM+s
         TRUr7HEKMaE8AXsQFbI3LSOmtoF7Ems1ZqemOCmbf6rbvzJFtfhNKx6cTbJPCoi/f1PZ
         JIoOGfdJK5Q6YLh3VD2kroBZNiBs1ZkvjJpvnxDgFN3CJKI7uBZlWZ19IzahVE7uElRm
         Mc8gjZyXQW9FT3kp6y0+aV9pVjMIY1s1qzOdZWj/qMpSRKrNKxTyBG/HY12tdWYhqavj
         +C5xWcZq9ENGx/eM/p73iwZ7wUnDkpNDq+zPfh6QqE9BNf03N3L9s8NQDIDooAp9Av9F
         oPcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WxRWrohRC+fNvhhMsjBNKWfMlLneWiOcUehlHfN3ctw=;
        fh=qm4uIL+aQLw7n6AuHh47rL7A34H5xnxYm/82C8VIB7c=;
        b=gjiw2PTzngSae+vCTWTFa4ThNNPSowlenf1ZgrvSpMMK/zY8sfw5S9AvAGtl7C83YU
         zubu8hsI1zg9CWRYROQ/V1iWEPO6+kpEe5sAaaFYWdLMmkL8SU3OiJYLCnIF9tlbRz8n
         Na7vxqLBQ3GZ29Ro52todsriZDXk4mN0+LPWu3Ny+sX322TOJWPOAHxFYQB9+roV8kfW
         1dcaxYvuQ5I3ziKSbxTxNPQp00mmr7WFKF0MiGvulrpsLwLi/OORtc//bPYbhoeIvD3t
         l8owxSk3QTOlGKJdQ324m9nMrk0qE5lA009/SDFmkaWuD5/mqqmS0jI0wG0I1xyC6Ehy
         otGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774801127; x=1775405927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxRWrohRC+fNvhhMsjBNKWfMlLneWiOcUehlHfN3ctw=;
        b=FrzopNnu1K3dOdZ3TusFe8IBsytL0sNJAtbEJkAi2Ep8ulCYvIgLXG4+vwzGZL2WTj
         dcNudB5wUTfvIW5re3cUZG1++D3fhNZHa7genkw4HI1c7csQf1RXcAHwTh5tuOB3y5Ac
         NhqgOzqMP+I9e1gDGtW9RHi0h9GiWlGWkoV8VZ9vMGW20CnRMLgxv93uoi+zKLL5PqT7
         lihAloiFoH2AGTujWWUiAFI749sAv2zVeMRfU/ziSpIjWTK5dBcrG6sRO3MGavZt6fU9
         E6j+o3xX2I0lIFURRwKtsQcu1qw4zO3iHzPjhkW81uQG0TxQUR40RLPD0mgcCnrfoU6b
         yfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774801127; x=1775405927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WxRWrohRC+fNvhhMsjBNKWfMlLneWiOcUehlHfN3ctw=;
        b=UC25EFV693O3YESmFcIYRQCMGAv3/nlhX9Wz4x/nt10YGy04rgmUF7z0Qdv6vQRxzX
         rcYAcul8ZAX+DjYb8hEKtWoyI3m4dSO6vhr1Gpe06TXALMmSohytvkaOKB4xR9jo/ms/
         cuJQ4TibPqZKhN55094nCCG559eORP8DkHqTo36OCFZI2nJA8mOKav9TCDpyTB5w0oQl
         +1CaKWufwPNxRDqfr7KXAnXyc2QuHHfIjjwC3gH/ovbGZmnXJV4lMlNUlfUm4kvXdmvo
         NUY19ZQdRMpJw382xomQrYKBAWeBNFHie6fXcNHtQzhQgl44ghCtV+FTzwk/rLvEFHMh
         4wdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlt7a4h8cPTSJP/8zPgxz4+TmRrNrfLjG7yGgRIXU30ixJ2KBeX0vmnTNGD6ClaTU4JvEABEPI/MLU@vger.kernel.org
X-Gm-Message-State: AOJu0YwqD4C9VIbC068hb/e3J1birKyA1ekK8/cRILxmM0TJ2mCPFN9k
	Hh0MDD2JD4NPWXKk7ptuyQUM9NRfSOSFvfnBhmVxPgEahd0lG4yLnnRXHfXNifbaeU4ISCsnIo7
	7tEfBLIJ/FaH9JEHYHDTnlC4nOcFFSuQ=
X-Gm-Gg: ATEYQzyqERX926q/+019RXW9j8xfz0XwMAHtYIzWSCMnsar48w0gP97yZK6Z88cymQM
	13ZpJISjeLAguEIlrfnCamXT0gJqQquKgm8V5xg0WhRDT0HT7rAxDswjtmJnsRmIKmWAqrltXdl
	a9d1AyvWruOo2ZsSNQLwA0QFn2GtoNPGgDouIbpdK4bU1GqVV+6nwUEjAbl0POomz4xlp55GPv2
	jem0Rv+v6o+jn8mWgOG9CqVSoC5KrMQv/WG0SuaPdpchJtQs44M3ExUyaro2OBvLKvZ6mxkQDof
	3Rvv36If
X-Received: by 2002:a05:6808:1909:b0:466:f25d:3281 with SMTP id
 5614622812f47-46a8a535f24mr4527393b6e.29.1774801127539; Sun, 29 Mar 2026
 09:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327151112.5202-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20260327151112.5202-2-wsa+renesas@sang-engineering.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sun, 29 Mar 2026 11:18:36 -0500
X-Gm-Features: AQROBzAT0Y7MQA0Vu0exbVKBXS_ASbnND8ZlhVVTpfO0frVJ0Okq55qzNtMBYvo
Message-ID: <CABb+yY3J2T5c4=dGaqPYi3L=88zgTqRn6AJwxBJ9Sqx6aDH8jw@mail.gmail.com>
Subject: Re: [PATCH v3] mailbox: remove superfluous internal header
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Sudeep Holla <sudeep.holla@kernel.org>, 
	Daniel Baluta <daniel.baluta@nxp.com>, Peter Chen <peter.chen@cixtech.com>, 
	Fugang Duan <fugang.duan@cixtech.com>, 
	CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 10:11=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Quite some controller drivers use the defines from the internal header
> already. This prevents controller drivers outside the mailbox directory.
> Move the defines to the public controller header to allow this again as
> the defines are not strictly internal anyhow.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>
> Changes since v2:
> * rebased to 7.0-rc5
> * add tag (Thanks, Daniel!)
>
>  drivers/mailbox/cix-mailbox.c      |  2 --
>  drivers/mailbox/hi3660-mailbox.c   |  2 --
>  drivers/mailbox/imx-mailbox.c      |  2 --
>  drivers/mailbox/mailbox-sti.c      |  2 --
>  drivers/mailbox/mailbox.c          |  2 --
>  drivers/mailbox/mailbox.h          | 12 ------------
>  drivers/mailbox/omap-mailbox.c     |  2 --
>  drivers/mailbox/pcc.c              |  2 --
>  drivers/mailbox/tegra-hsp.c        |  2 --
>  include/linux/mailbox_controller.h |  5 +++++
>  10 files changed, 5 insertions(+), 28 deletions(-)
>  delete mode 100644 drivers/mailbox/mailbox.h
>
> diff --git a/drivers/mailbox/cix-mailbox.c b/drivers/mailbox/cix-mailbox.=
c
> index 443620e8ae37..864f98f21fc3 100644
> --- a/drivers/mailbox/cix-mailbox.c
> +++ b/drivers/mailbox/cix-mailbox.c
> @@ -12,8 +12,6 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>
> -#include "mailbox.h"
> -
>  /*
>   * The maximum transmission size is 32 words or 128 bytes.
>   */
> diff --git a/drivers/mailbox/hi3660-mailbox.c b/drivers/mailbox/hi3660-ma=
ilbox.c
> index 17c29e960fbf..9b727a2b54a5 100644
> --- a/drivers/mailbox/hi3660-mailbox.c
> +++ b/drivers/mailbox/hi3660-mailbox.c
> @@ -15,8 +15,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>
> -#include "mailbox.h"
> -
>  #define MBOX_CHAN_MAX                  32
>
>  #define MBOX_RX                                0x0
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.=
c
> index 003f9236c35e..22331b579489 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -23,8 +23,6 @@
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
>
> -#include "mailbox.h"
> -
>  #define IMX_MU_CHANS           24
>  /* TX0/RX0/RXDB[0-3] */
>  #define IMX_MU_SCU_CHANS       6
> diff --git a/drivers/mailbox/mailbox-sti.c b/drivers/mailbox/mailbox-sti.=
c
> index b4b5bdd503cf..b6c9ecbbc8ec 100644
> --- a/drivers/mailbox/mailbox-sti.c
> +++ b/drivers/mailbox/mailbox-sti.c
> @@ -21,8 +21,6 @@
>  #include <linux/property.h>
>  #include <linux/slab.h>
>
> -#include "mailbox.h"
> -
>  #define STI_MBOX_INST_MAX      4      /* RAM saving: Max supported insta=
nces */
>  #define STI_MBOX_CHAN_MAX      20     /* RAM saving: Max supported chann=
els  */
>
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index e63b2292ee7a..9d41a1ab9018 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -18,8 +18,6 @@
>  #include <linux/property.h>
>  #include <linux/spinlock.h>
>
> -#include "mailbox.h"
> -
>  static LIST_HEAD(mbox_cons);
>  static DEFINE_MUTEX(con_mutex);
>
> diff --git a/drivers/mailbox/mailbox.h b/drivers/mailbox/mailbox.h
> deleted file mode 100644
> index e1ec4efab693..000000000000
> --- a/drivers/mailbox/mailbox.h
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -
> -#ifndef __MAILBOX_H
> -#define __MAILBOX_H
> -
> -#include <linux/bits.h>
> -
> -#define TXDONE_BY_IRQ  BIT(0) /* controller has remote RTR irq */
> -#define TXDONE_BY_POLL BIT(1) /* controller can read status of last TX *=
/
> -#define TXDONE_BY_ACK  BIT(2) /* S/W ACK received by Client ticks the TX=
 */
> -
> -#endif /* __MAILBOX_H */
> diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbo=
x.c
> index d9f100c18895..5772c6b9886a 100644
> --- a/drivers/mailbox/omap-mailbox.c
> +++ b/drivers/mailbox/omap-mailbox.c
> @@ -22,8 +22,6 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/mailbox_controller.h>
>
> -#include "mailbox.h"
> -
>  #define MAILBOX_REVISION               0x000
>  #define MAILBOX_MESSAGE(m)             (0x040 + 4 * (m))
>  #define MAILBOX_FIFOSTATUS(m)          (0x080 + 4 * (m))
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 22e70af1ae5d..636879ae1db7 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -59,8 +59,6 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <acpi/pcc.h>
>
> -#include "mailbox.h"
> -
>  #define MBOX_IRQ_NAME          "pcc-mbox"
>
>  /**
> diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
> index ed9a0bb2bcd8..2231050bb5a9 100644
> --- a/drivers/mailbox/tegra-hsp.c
> +++ b/drivers/mailbox/tegra-hsp.c
> @@ -16,8 +16,6 @@
>
>  #include <dt-bindings/mailbox/tegra186-hsp.h>
>
> -#include "mailbox.h"
> -
>  #define HSP_INT_IE(x)          (0x100 + ((x) * 4))
>  #define HSP_INT_IV             0x300
>  #define HSP_INT_IR             0x304
> diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_c=
ontroller.h
> index 80a427c7ca29..16fef421c30c 100644
> --- a/include/linux/mailbox_controller.h
> +++ b/include/linux/mailbox_controller.h
> @@ -3,6 +3,7 @@
>  #ifndef __MAILBOX_CONTROLLER_H
>  #define __MAILBOX_CONTROLLER_H
>
> +#include <linux/bits.h>
>  #include <linux/completion.h>
>  #include <linux/device.h>
>  #include <linux/hrtimer.h>
> @@ -11,6 +12,10 @@
>
>  struct mbox_chan;
>
> +#define TXDONE_BY_IRQ  BIT(0) /* controller has remote RTR irq */
> +#define TXDONE_BY_POLL BIT(1) /* controller can read status of last TX *=
/
> +#define TXDONE_BY_ACK  BIT(2) /* S/W ACK received by Client ticks the TX=
 */
> +
>  /**
>   * struct mbox_chan_ops - methods to control mailbox channels
>   * @send_data: The API asks the MBOX controller driver, in atomic
> --
> 2.51.0
>
Applied to mailbox/for-next
Thanks
Jassi
