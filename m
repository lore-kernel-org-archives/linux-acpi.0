Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958A6EB64DC
	for <linux-acpi@archiver.kernel.org>; Mon,  3 Jul 2023 13:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjGCNa0 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 3 Jul 2023 09:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjGCNa0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Jul 2023 09:30:26 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E65E41
        for <linux-acpi@vger.kernel.org>; Mon,  3 Jul 2023 06:30:23 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3112f5ab0b1so4954229f8f.0
        for <linux-acpi@vger.kernel.org>; Mon, 03 Jul 2023 06:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688391022; x=1690983022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZnnVKMWmgBZv3yMj96JcjDuZoVh3HEOvpCHPpz/5Hw=;
        b=RhWjkWg47DeZvNYSTBWmzfRWp/NSRN7KvZP+k+WDia+g2UwEY3uMkFbc0PV4+VjKxI
         ihlj1ack+jSKLBZDbdWN2Rn8TG9dLXZKmOi7ZWLwSFfTG0si6eteY/Q2W1reSpUmiG4Y
         Be3f4CybS9YtYRzva4QvLgWuhRgQIifKVjD1MStbRBDUzKFx+/1KkHSvNjAkUJdYOjOE
         843n9xW8eodngvmbdgGDyxUO63z8v2yQmYuRcO2CDPTM2aVXyOlxXnlrs7ypp363cSdB
         txQZYnhUHB7E5T2sN+H3RLfcVqE25ongv8xBfXwTPA15FyxbfZ7FF7aAMaIjd+W8hr8M
         zl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688391022; x=1690983022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZnnVKMWmgBZv3yMj96JcjDuZoVh3HEOvpCHPpz/5Hw=;
        b=ds4/Bk9eU+hNm9of7BhosgwSgKNBkD8r4LhlcEjB6Iz75zzZr0SmNyVrN6c6VqrBXE
         cMLBqrrpGkq3S1dFy93V9aERQboy+5F+P3fs/OI1mQWL480/NGj14O5RZqbso4WaoBxu
         avcL77YL5pVpF988iNAxpbEvtrvNHyiprFGpKSXvzRebVI5qVVHQDdPgfTC31YRW9O+z
         UNQ7dPHpIvaCC/oYh1XabGm8KnG7gjRmwFMte5ILlcWeUMFXK3MAqgkS6/UfOL/N7sAG
         bqCTY8oyeMahyzoIkoml6v76llsXiVOVmzY8Navmf85bZG2FdwlZ9GrUjtVI3cOpdZ3y
         Tsfg==
X-Gm-Message-State: ABy/qLZh5QyCitfWt/FbsyKOjUflXAKXausHCmtN4/5ZKP39bVqNWiUn
        cBUey+uKJCQHvQ52aZw2utQKCkfCuZa0STXocSAcMQ==
X-Google-Smtp-Source: APBJJlFLHnoWLC7fXKGELY0yfhUnCQIhkvaJIxen0SRkggMiciJCwTGHTehB9bng5XROJZG+5KrStqYwIAfQ6Z10yaU=
X-Received: by 2002:a5d:5410:0:b0:314:17b0:d35c with SMTP id
 g16-20020a5d5410000000b0031417b0d35cmr7098244wrv.55.1688391021887; Mon, 03
 Jul 2023 06:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230702095735.860-1-cuiyunhui@bytedance.com> <20230703-71f67eb66a037f5c0fb825c6@orel>
In-Reply-To: <20230703-71f67eb66a037f5c0fb825c6@orel>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Mon, 3 Jul 2023 21:30:10 +0800
Message-ID: <CAEEQ3w=7tBHyG=CvuktPN5cvfpY6ayamnbry6eOYxMDrPN+oZg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/3] riscv: obtain ACPI RSDP from FFI.
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     ardb@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        rminnich@gmail.com, mark.rutland@arm.com, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi drew,

On Mon, Jul 3, 2023 at 9:01=E2=80=AFPM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
>
> (This is a reply to a non-existent cover letter.)

This has been discussed many times with Ard, Please refer to :
https://patches.linaro.org/project/linux-acpi/patch/20230426034001.16-1-cui=
yunhui@bytedance.com/


> I'm not a big fan of adding yet another interface. Have you considered
> doing something like [1]?
>
> [1] https://github.com/tianocore/tianocore.github.io/wiki/UefiPayloadPkg
>
> Thanks,
> drew

Thanks,
Yunhui
