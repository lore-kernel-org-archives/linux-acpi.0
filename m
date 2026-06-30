Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8495015B135
	for <linux-acpi@vger.kernel.org>; Tue, 30 Jun 2026 12:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782822805; cv=none; b=Ll2AfLD3oWi0UFloCQPSDgkFX5wfa57cPPeOMgpLkl5g74vPjBHGbFU35GOWDObSlhat7SFxMTKSLnqewJN8NxqtutuJaeR8l/HA+IaRJxPFUe7pa6RYmhjgmhjRrffxdvGCM7KRfKSKuQehsT56kaisZutR8EUwekJSZmIVM88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782822805; c=relaxed/simple;
	bh=9wNLEI+iMVleXl7q7uPKgvFOzElU5dKByOwpWV4y5Nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q/p0ev58mCxHEiT68hLW4/I8zgBIkCz4FWdkkJR37BSQWBaWpMAd18jmwG4Cmps6voXTGM44/BRCvp4wrPIYWG40s74lysaOwCEueBdtGTxW+sy7b5jAXme4TuAbpQi18EJOIhvRTcnPwoDeJZ8+W6EXs68+/3kEOgj3ShNsbGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJSHULi4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJSHULi4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCC61F00A3A
	for <linux-acpi@vger.kernel.org>; Tue, 30 Jun 2026 12:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782822803;
	bh=y4l/ItTQhtVzgs8BjuU395yo6q+E0W4sD6kjTOjFSaQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YJSHULi4GC6KXHl11tCz7r42IH76Qdolyf/ViCJgu0+5/ThqTZf85bPAKPCtz7OcF
	 lyurf+hl8daoYZmxiGOHBF4dBEOpCOLhUUChaqJ6432Y54nPoBYhpvP5IS7sfuN7I5
	 PfdySQZNZIF4f+D8aN1UGktCn1yrAUMH9V1kVD30rE2ljmswdPy4cqMhaK/nUpUSfI
	 FAv8eA208UPpK6dRoW4Va4eb/cCDj86voKWsKeyCePIfk+txxCe2wQL9JfdxAkxoiH
	 /CO2mvZU0M7hRaBKj5kjmSQDZrolGs5Cq4gD0D/U93pm8rpKxnCh3UbvNiTZrUuDpz
	 V3SPe1BnDXiQA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aeb2df5cc1so2122930e87.3
        for <linux-acpi@vger.kernel.org>; Tue, 30 Jun 2026 05:33:23 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxc9ZZ2bzdQBYAcFzbVEmnsVNuFrFba9wrp7e0IvBgDp9wPfWUK
	NMxUbalEs5lik0bKOqZ1y2ixRehezuFn8W4udYvs/UFNfaLjSPwLcD9MJrWgMuPg+T7B+cCWd7l
	Mt7u5zCR6CXKaQB9oLtCV+Nt9MLKDcas=
X-Received: by 2002:a05:6512:3b9e:b0:5ae:b0a8:7d73 with SMTP id
 2adb3069b0e04-5aec10d13ebmr137621e87.64.1782822801648; Tue, 30 Jun 2026
 05:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627-acpi_pcc_signature-v1-0-c1b7268d4fdc@kernel.org> <20260627-acpi_pcc_signature-v1-6-c1b7268d4fdc@kernel.org>
In-Reply-To: <20260627-acpi_pcc_signature-v1-6-c1b7268d4fdc@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 30 Jun 2026 14:33:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j5RtaadVjTLm7rghNiz_9b4_Rs4PPQZgAinud7tssgEA@mail.gmail.com>
X-Gm-Features: AVVi8CfGfb0xWQBROsz_cDgWR2p9nMI6GsLFxFQ3ACKQ4JP75mMLEFOg7mdWpMc
Message-ID: <CAJZ5v0j5RtaadVjTLm7rghNiz_9b4_Rs4PPQZgAinud7tssgEA@mail.gmail.com>
Subject: Re: [PATCH 6/6] ACPI: PCC: Preserve shared memory signature in
 OpRegion handler
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2026 at 6:39=E2=80=AFPM Sudeep Holla <sudeep.holla@kernel.o=
rg> wrote:
>
> ACPI defines a PCC OperationRegion as the shared memory fields that
> follow the PCC signature. The OperationRegion length is likewise the
> total size of the fields that succeed the signature in shared memory.
>
> ACPI 6.6 adds clarification that the PCC shared memory signature is
> populated by the platform and verified by OSPM.
>
> The PCC address space handler currently copies the OperationRegion
> buffer to and from the start of the PCC shared memory region. That can
> overwrite or expose the signature at byte offset 0, and it also misses
> the last 4 bytes of the actual PCC OperationRegion data.
>
> Offset OperationRegion copies by the size of the signature and reject
> regions that do not fit in the shared memory after that signature.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Fixes: 77e2a04745ff ("ACPI: PCC: Implement OperationRegion handler for th=
e PCC Type 3 subtype")
> Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>

Does this depend on anything else in the series or is it independent?

> ---
>  drivers/acpi/acpi_pcc.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
> index 438c67189511..9881c9ee293d 100644
> --- a/drivers/acpi/acpi_pcc.c
> +++ b/drivers/acpi/acpi_pcc.c
> @@ -28,6 +28,7 @@
>   * to PCC commands
>   */
>  #define PCC_CMD_WAIT_RETRIES_NUM       500ULL
> +#define PCC_SIGNATURE_SIZE             sizeof(u32)
>
>  struct pcc_data {
>         struct pcc_mbox_chan *pcc_chan;
> @@ -74,6 +75,14 @@ acpi_pcc_address_space_setup(acpi_handle region_handle=
, u32 function,
>         }
>
>         pcc_chan =3D data->pcc_chan;
> +       if (pcc_chan->shmem_size < PCC_SIGNATURE_SIZE ||
> +           ctx->length > pcc_chan->shmem_size - PCC_SIGNATURE_SIZE) {
> +               pr_err("PCC channel-%d shared memory is too small.\n",
> +                      ctx->subspace_id);
> +               ret =3D AE_AML_REGION_LIMIT;
> +               goto err_free_channel;
> +       }
> +
>         if (!pcc_chan->mchan->mbox->txdone_irq) {
>                 pr_err("This channel-%d does not support interrupt.\n",
>                        ctx->subspace_id);
> @@ -97,14 +106,17 @@ acpi_pcc_address_space_handler(u32 function, acpi_ph=
ysical_address addr,
>                                u32 bits, acpi_integer *value,
>                                void *handler_context, void *region_contex=
t)
>  {
> -       int ret;
>         struct pcc_data *data =3D region_context;
> +       void __iomem *pcc_opregion;
>         u64 usecs_lat;
> +       int ret;
> +
> +       pcc_opregion =3D data->pcc_chan->shmem + PCC_SIGNATURE_SIZE;
>
>         reinit_completion(&data->done);
>
> -       /* Write to Shared Memory */
> -       memcpy_toio(data->pcc_chan->shmem, (void *)value, data->ctx.lengt=
h);
> +       /* Write to the PCC OperationRegion after the shared memory signa=
ture. */
> +       memcpy_toio(pcc_opregion, (void *)value, data->ctx.length);
>
>         ret =3D mbox_send_message(data->pcc_chan->mchan, NULL);
>         if (ret < 0)
> @@ -125,7 +137,7 @@ acpi_pcc_address_space_handler(u32 function, acpi_phy=
sical_address addr,
>
>         mbox_chan_txdone(data->pcc_chan->mchan, ret);
>
> -       memcpy_fromio(value, data->pcc_chan->shmem, data->ctx.length);
> +       memcpy_fromio(value, pcc_opregion, data->ctx.length);
>
>         return AE_OK;
>  }
>
> --
> 2.43.0
>
