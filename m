From: Pekka Enberg <penberg@gmail.com>
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
Date: Fri, 11 Feb 2005 14:02:19 +0200
Message-ID: <84144f02050211040253e33dab@mail.gmail.com>
References: <20050210161809.GK3493@crusoe.alcove-fr>
	 <20050211113636.GI3263@crusoe.alcove-fr>
Reply-To: Pekka Enberg <penberg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262122AbVBKMCW@vger.kernel.org>
In-Reply-To: <20050211113636.GI3263@crusoe.alcove-fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Stelian Pop <stelian@popies.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net, Jean Delvare <khali@linux-fr.org>, Pekka Enberg <penberg@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, 11 Feb 2005 12:36:37 +0100, Stelian Pop <stelian@popies.net> wrote:
> +static int __init sony_acpi_add(struct acpi_device *device)
> +{
> +       acpi_status status = AE_OK;
> +       struct sony_snc *snc = NULL;
> +       int result;
> +
> +       snc = kmalloc(sizeof(struct sony_snc), GFP_KERNEL);
> +       if (!snc)
> +               return -ENOMEM;
> +       memset(snc, 0, sizeof(struct sony_snc));

Nitpick: use kcalloc() instead of kmalloc() and memset().

                                 Pekka
