Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19C835CB71
	for <linux-acpi@vger.kernel.org>; Thu,  5 Feb 2026 07:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770276371; cv=pass; b=XyAhyJt8VCbeVvATEPehBs7iSrltZY44JvnrUJdNNOFi8acAUu4/koLboLC6LyK768gWWd7x7rm9pvVI9Lq7aMu0NKV9SXgl9lIn+JqLJYEA6bxwQ5mdKsgUaSz6oJCr6xsUOshxDKWp7Q4j42YY0hfJLCfhm31wNXycMBHzAbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770276371; c=relaxed/simple;
	bh=chZKh7A+dwWXNFgyj26v5tyLr+o0hwC6/62AqhwxVbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gByNYrR+XnT+qvfRIpBjddsrSWp3c3oaFehip08NaAmYKyt8JSNS99Ua1rUF5l1TxcCtr2tfaAa4HStHZWpvaI10dO9PSkxsIc8DbTFKRUBObFvnLMX7HW4lupwXMEAWfn6V7FSpBXVC0fwM+xJMAu8c1VZ0F9Xy541VcpTS7E8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=Kam+OgNS; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="Kam+OgNS"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-382fceabddfso5653411fa.1
        for <linux-acpi@vger.kernel.org>; Wed, 04 Feb 2026 23:26:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770276369; cv=none;
        d=google.com; s=arc-20240605;
        b=lNcWoK5OhiP7YklEwgqxj99Cw91j839+ugpPxfu05J75WfDE4G17Np7J256jSWbaUF
         NrqFo98GNXpZ+mGJLYuLVjH5LzvMUzJQPoZ/4Xf6EJvWvVaodK2qjjq6bX9znMIiI1fx
         w/eIQaVUnsRolRt9ECcvfXYrg4zVfoNleyxTW9ndrr18dhkV5VFARF4eZVo0fyuvmtu2
         Bd17lfwZDEXy1oBVfgOLQktiiuU9mTTh1o6hUi27+Se2mpqgzOOuf6AtoA/s37TWe9NG
         lrxOGBDIN0WfeK9pbJpBeck/gmUTidOZfrcuEqhyHdDV+1FSUVbxvqKQh3FKR7CEcEZP
         6MJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EabkhdlekNaIrQNqdNsBDJghU9qF/F10EyqKMiZd5os=;
        fh=iukkpI/9WhxgN30Cd0OSINTNUefAiRvrcauzAKwmm/U=;
        b=GDCQZHnTvNqvVcpiJLWYeDUphzcGDw88oRLvFQl1Levjw35B6FB+bcSKuWZZqwdg8F
         HpUqBYXsBRozL1N+tg7DF9zkSU7s63EWYQR6tzDocStvkdRGS/Y/fYz/JlUd9PeUXpfY
         zKf14vbS4qKZTffqTHToXrPQ7ihMRprUB6RhqlsHDIeueoc5Ys51YTiFQR42SydStYU5
         Oc3WFLeZE3ZM8AOu1L4D+mp5xYml2kHW5vT5zu2/3+an1HJveVMWp3acGh2pSpZ5CLZn
         7/G4QyR4Jrw8Dovq8p5bGAYC2sEsmpQaMLx5RCwVMT9IvUFS7g4UgV7vwUKl81oBVTgO
         c9kQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1770276369; x=1770881169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EabkhdlekNaIrQNqdNsBDJghU9qF/F10EyqKMiZd5os=;
        b=Kam+OgNSD4xgUZIfe7jcYF0AfD+/UXYDZmKDbbppG9rykBX6MjSyTMm5eKX0aPrxP3
         o+ggR7S/cyrNH/nyhMChx4ZZ87zI8kpKOCOnsJW4ph6/e7/m+E8kYW6u0UY2gDNW2RRe
         M57nsNfgpqBNHclA8ufafrWAMdA5GsfdTH6Jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770276369; x=1770881169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EabkhdlekNaIrQNqdNsBDJghU9qF/F10EyqKMiZd5os=;
        b=ftzwelOrFvzvtCdSitUEeD5LO73qyEWOMtxOoCgUUnfdwZZVvgZSJ7yphx8EK89A0T
         YlrrqF2gjfVppimLtcPZFn3HoFU13Ptnk3Qm7wtmcsl+qGeDJhTl8tpJBNO+k/b4gJ+i
         smumNLf2vtQF+gbjRPGXBwv4X3ljoTmIGCO8fX8w+1fg6SdKuO4RQetmj1yo7hkgHnXr
         X9y4t2qXVAupYoQccf/cgnCY/+IhouFgTSmi00QQM2Qz8rWbCCqV3W9u6glFEylYCEWn
         agnj+2tSNjX/j4aRA0xpKE87WyDw5R4OkmSg4R4p3mVT+T5eEZlT5OL9mdP766ddYuYc
         G7Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVAd7k6O1S6LpAfaHjKqgYfSCuANTF369PaIBkxv7M8bM7RcEIVwF94vKbe7kFNgq9s5aThgAeBZSLV@vger.kernel.org
X-Gm-Message-State: AOJu0YwtzNNAilzhdqp1KaH20c5SCZIvyFExQWnJgLrBF/sw0V2PrRtF
	BQyh8UXZhMI61D/Q4/ajS+p1v/JBzngijr5oP+EsjthLqTcStczHh2BmNtrpB7hyT6zu093Bw7U
	JJ6H1V9dlnw9hMQG2yMcP+Tuypo7XIq5lm7pvjAb+
X-Gm-Gg: AZuq6aKxPyWHi2LRkbROxt+I7krCJafrZ+p3nycazh3sDkXXWvK6zefmyVAQWKmn+Ai
	2RCE+6sXyIhg1SfFrtOMAFDSX0J7G7/69Dv8ILRO0TeQRdg5P4vz9CwyTTcMn1jU1t3slV4lDr8
	HzgHTOcsnN6KLUFuMi4jQ+6t7p6vc9Wv2gGE92mb/jeIm5/lsYvxxArXqTIM3z/WMuU7FF19zGg
	N+Z0k0Rdklbx8pxgFGvPyJqLWZ3zsqICNnGycKX4yQ+X6yISM2ZClRTsNo/1LdFkxiaZ8Cb
X-Received: by 2002:a2e:a543:0:b0:37b:b849:31c3 with SMTP id
 38308e7fff4ca-38691e806bemr19213511fa.44.1770276368914; Wed, 04 Feb 2026
 23:26:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <CAK8fFZ4izdX_HDtGN60CZ3Ta61nqkUg7ncViM=mGgxKki_5FoQ@mail.gmail.com>
 <a7334568-13ce-4600-8650-607273e67976@roeck-us.net> <CAK8fFZ6gKs7s2rJ=f7bt24f+_cY-jGU33TvX3UP=U58uK-1KaQ@mail.gmail.com>
 <fff54ec8-496e-4c26-b652-358dc4de0de0@roeck-us.net> <CAK8fFZ4wEUdMAHkfdC_z8ohYB_rEXZ=dHArc75jDibgQ_-ozKw@mail.gmail.com>
 <4f151d4c-fdc6-4281-87b0-b7120eeb1b46@roeck-us.net> <CAK8fFZ401-nez_CgDTTnQiPT=oBRRJuYooXyEKFuCdHpGCPXtA@mail.gmail.com>
 <27d60756-d33e-4926-9a02-f52505339de6@roeck-us.net> <CAK8fFZ43wrQ8A_bO_g+rKN9O31sxULtqA0hUieZSzEH5KqeW1Q@mail.gmail.com>
 <CAJZ5v0hEu_io2BAzp9weUDHwHngorjZ37GRUK=ngSXNjtp38qw@mail.gmail.com>
 <CAK8fFZ65Vro5nQqJq_cvsY93hgDbfTdibWnNr5b0Bixzc-ESfg@mail.gmail.com>
 <CAK8fFZ6Vi4xayvdKh-_eLi-nDNMLuEoMsvwEnb33QqnwS7o4BA@mail.gmail.com>
 <1c8f748a-5c5d-4234-ae86-7bb12045a373@roeck-us.net> <CA+9S74i+BC3=E0opOPMff0cuC1OPYSecii0C8fVZ+NM7bptNcQ@mail.gmail.com>
 <fee01c19-2711-487e-91e9-d57f9be04b98@roeck-us.net>
In-Reply-To: <fee01c19-2711-487e-91e9-d57f9be04b98@roeck-us.net>
From: Igor Raits <igor@gooddata.com>
Date: Thu, 5 Feb 2026 08:25:57 +0100
X-Gm-Features: AZwV_QiwwcyEnfn_e-4mVVKJfsZWpooDgHk09kcus0RQYk-I2NY6LI7HM_zb4A0
Message-ID: <CA+9S74jR9jRRE-DNMxNg=6Uv2uDAUar2n-RkVDJqzkDfNu3eog@mail.gmail.com>
Subject: Re: [BISECTED]: acpi_power_meter: power*_average sysfs read hangs,
 mutex deadlock in hwmon_attr_show since v6.18.y
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	Daniel Secik <daniel.secik@gooddata.com>, Zdenek Pesek <zdenek.pesek@gooddata.com>, 
	Jiri Jurica <jiri.jurica@gooddata.com>, Huisong Li <lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 11:49=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 2/4/26 11:54, Igor Raits wrote:
> > I have written a patch with the help of AI and it fixes the problem. At=
tached.
> >
>
> "No MIME, no links, no compression, no attachments.  Just plain text"

Sorry for that, I had assumed that attaching the file would make it in-line=
.

> ... which means I can not provide inline feedback, which is the whole
> point of the above.
>
> Your patch crosses subsystems, so it will need to be split in two
> (assuming the ACPI side is even needed). Also, references to iDRAC
> in common code seem inappropriate.

Yes, this I believe was the essential part (it was the last piece in
my testing which fixed the hanging):

diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
index 5fba4dab5d08..ab1f4b27741d 100644
--- a/drivers/acpi/acpi_ipmi.c
+++ b/drivers/acpi/acpi_ipmi.c
@@ -572,7 +572,18 @@ acpi_ipmi_space_handler(u32 function,
acpi_physical_address address,
                status =3D AE_ERROR;
                goto out_msg;
        }
-       wait_for_completion(&tx_msg->tx_complete);
+
+       /*
+        * Use a timeout to avoid blocking forever if the BMC is slow
+        * or non-responsive (e.g., during iDRAC reset). The timeout
+        * should be longer than IPMI_TIMEOUT to allow for retries.
+        */
+       if (!wait_for_completion_timeout(&tx_msg->tx_complete,
+                                        msecs_to_jiffies(IPMI_TIMEOUT * 3)=
)) {
+               dev_warn_once(ipmi_device->dev,
+                             "ACPI IPMI request timed out\n");
+               tx_msg->msg_done =3D ACPI_IPMI_TIMEOUT;
+       }

        acpi_format_ipmi_response(tx_msg, value);
        status =3D AE_OK;

> Thanks,
> Guenter
>
> > I don't know how correct it is, but it works :)
> >
> > On Wed, Feb 4, 2026 at 2:01=E2=80=AFAM Guenter Roeck <linux@roeck-us.ne=
t> wrote:
> >>
> >> On 2/3/26 15:21, Jaroslav Pulchart wrote:
> >>
> >>> ...
> >>> $ git bisect bad
> >>> bc3a9d217755f65c137f145600f23bf1d6c31ea9 is the first bad commit
> >>> commit bc3a9d217755f65c137f145600f23bf1d6c31ea9 (HEAD)
> >>> Author: Corey Minyard <corey@minyard.net>
> >>> Date:   Wed Aug 20 14:56:50 2025 -0500
> >>>
> >>>       ipmi:si: Gracefully handle if the BMC is non-functional
> >>>
> >>>       If the BMC is not functional, the driver goes into an error sta=
te and
> >>>       starts a 1 second timer.  When the timer times out, it will att=
empt a
> >>>       simple message.  If the BMC interacts correctly, the driver wil=
l start
> >>>       accepting messages again.  If not, it remains in error state.
> >>>
> >>>       If the driver goes into error state, all messages current and p=
ending
> >>>       will return with an error.
> >>>
> >>>       This should more gracefully handle when the BMC becomes non-ope=
rational,
> >>>       as opposed to trying each messages individually and failing the=
m.
> >>>
> >>>       Signed-off-by: Corey Minyard <corey@minyard.net>
> >>>
> >>>    drivers/char/ipmi/ipmi_si_intf.c | 29 +++++++++++++++++++++++-----=
-
> >>>    1 file changed, 23 insertions(+), 6 deletions(-)
> >>
> >> Now that is interesting. Does reverting that patch on top of 6.18.8
> >> (or any other 6.18 release) solve the problem ?
> >>
> >> Thanks,
> >> Guenter
> >>
> >
> >
>


--=20

Igor Raits | Sr. Technical Manager, Platform Delivery

igor@gooddata.com

+420 775 117 817


Moravske namesti 1007/14

602 00 Brno-Veveri, Czech Republic
