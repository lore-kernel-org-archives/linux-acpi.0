Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2484A23370F
	for <linux-acpi@vger.kernel.org>; Wed, 15 Apr 2026 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776279275; cv=pass; b=E7fVzUYAgT4QxjJl0BQlQu6hQzBkyalYdwQjuTKVZsdSlizOkkAw5m7EfAf1BORwFZqkx9e23yqadIvbg+LdrU2CzqsXZvjWBxWlf5SyBuyMrDtyeMHKsgfnInN1BCeN7Y44N1hjTKV5OgOYsLH+QHzv3sjAJovgFdQgJMl7xKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776279275; c=relaxed/simple;
	bh=fQaHT0WZJOK65WyNe4PaPMmmwzlL0FOR1eTK/cw4iBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tHfyfy5r4LZiZXDQbqaMRo1int106PWQydeYTVfdWOaHL8KVrlzT7zkfhqH90GlEHCAVK5BYwO+aj5N5dGuNiaUE/VeiKISju3V09tXFnqlsDjZ/63RwON2Uxmh+jSZ4RrYM3Edw/kDrpURFHPRSQguz23X4jqO5V76bILzeNo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RDsjYxSC; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RDsjYxSC"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50e237ae754so83581cf.1
        for <linux-acpi@vger.kernel.org>; Wed, 15 Apr 2026 11:54:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776279273; cv=none;
        d=google.com; s=arc-20240605;
        b=JAzV86y15SnyJb6qVOxmFiVxaGlifHzKgyQ2JGuNN8sPAUH7dKnw+S4mxuEiTOESua
         N2tY1b3sGTBSSTfkR56d75e4c9CvbVPEdHXQ3dBvUyBco3vwRczqaO0xm5I7FF3bWE8W
         Fj/EjtX3zXkBOjLiwG6KAnKzPgbe2Grw3OGQqjLZ5Fx/rXuNTRxOrI3jOViiGEZfpREk
         O/sO0DsnUyQZJBBRRqMmhFkxH3RhKjZ26CKKsUSmZ4CJ7DqyRk790p6sCiZwL1ysrIW+
         pTHPoxCjOBvkTk6FzssC09rPQvxyLbxzZtuXFjns/OkNQMy8jHY4snCFC7sdOWYv1/ow
         IYoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fvmVAYeUdSrn9HdmiZpJD5pxR8Gg76A8Jpt7CDjD65g=;
        fh=S9eC6dr2x/JQtQQWKSIoAnxaikko6aEXUjJVUTuYX8o=;
        b=WnsGIy9Hq5vnnTRr1tzXxPHLQZO+q5+onGq1Am9VAk0cpIYbxBon5Lo64p0sOyee7I
         wWTNlBTCjrBOabW0mH/O3hidHdF+G/qWT//EGa/pO0gcPbbF8f7r80PUG/z0mGnaihLj
         uGQzoAS3m0RazvEZqT8etP2GGzI8MzHdBykLUihxioqv//V+1EU2iy2SAWTotgb0GJ55
         beaKEWRjCgorKCNeiZnDTAZ9sohhg3qGuSdlHy4ReS/2rygOIUSb5aL8ILoDcoVIZO2D
         ITU/hjbP5qJRbtUkO/jvuxBq8hcff7OYiW9HG594+EkY0rCaO3NL1/996mqT3bwsYQvW
         XMTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776279273; x=1776884073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvmVAYeUdSrn9HdmiZpJD5pxR8Gg76A8Jpt7CDjD65g=;
        b=RDsjYxSCSeldUQGQ90qQhqsEp9gkAuElTw3S3XI5IguBUlgc7glpcWHsCX+/cvXZjr
         Tw2NdblLILCvVzOnrD9khn2VkTdR999T+ZnYGP1CPVYSL7T8nYduEUmt2b1JYr2amlCj
         kHjXWYOhlhG1HbGT2/bitKM+1dJ75WwtoN0NHrpGyP8iiJIj2xgUNxQ3SFljZe8DXs75
         ECUipGnTt/RrepoIm0FL3bvBcQo+jwvLiahD1vq4FSmSUNl9iRNRBEXi+w4x07zrusEG
         mTFwjuJYZEP+F9MpmEv8x0PfdQXB0XniQGs5UJgV54/xf1wOd2Pl28cRrdXEm58FWvN8
         M//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776279273; x=1776884073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fvmVAYeUdSrn9HdmiZpJD5pxR8Gg76A8Jpt7CDjD65g=;
        b=MsNYNh2MaujOLwc1Zfk4AosYkuT/mXPMKMY0ehR51ex43AO2CPIXMBCz+Fwc23tDGt
         k/XH437vZ7+0B3z1M24SQBblBBQGc/Horvu5muQXR7/xelGGmAFAIUWi9a1IPIg27wBS
         uVNap8WToU6Uc5/5rBnU4Y740n4xLIPOXQhvq+LoOJ3gz8EJEB6VsfBgA3D4LTzwVdcM
         sqP/MLqsSgh6WKJYCmMvOJ9lLJk/MFv63jLHSZnBD9pwVyAX16JT/wL2RZ020UCvLDHE
         62XZsxoe5N1CIXBG9ou3SnFNGzJRIauyn/IsvMnb8TPFzgNOK6jBwvUP3TFIE6o7reZl
         6L0g==
X-Forwarded-Encrypted: i=1; AFNElJ/lhkWGViwxDoUVip996otD7zmxYq4TrZiWC+hXvdrX1neXpxk1e25KFxvc3+kpvHE5v/GsZtAoeCr5@vger.kernel.org
X-Gm-Message-State: AOJu0YzrPQOHImkMxJx/VuwnSSQzBb1sXsTGLHZMuUJr521o4T278nwM
	sGbQvidn3jLXFUQ1kWcm4AjAhQnHA/EKR29MLL2BF0Ca7x2Zbg0kkrYrSEC/+qRZqK+GFGPuOc1
	JD7xkutZxV2zoDZzI9S0TaJjMB26UKqjGJw8EHcBW
X-Gm-Gg: AeBDietoY9X49rKRkuoJtW4eLQNg4M24G3+XE+fw9z7zsCehoUFZsoQhR3zeI5oYo3C
	j880O5r0MNEOx+ZzIxwqDy7TMKH31KCh7BIRxoKcguKjI1gLLQfi8TrPeLOF+SfytjH1yGOm5Y4
	wRzLzMRJwmyQKOwKjMDnjAnV3GQN41s3sQeBRCzseD0rZ79XQ20DzSufZiK+E22YCfoxI9pSyAj
	2xHC+pVmR/aA+ttIE7Kk2wRm+OswjuXQQwEAXWmecc/UvDyAOjvQ9Sea0cg2dhk9vKCXAcMgNQR
	B1MZgWIfDPWVB0iPRJ31mdwDj9O3cKL46ss38cDNilzT4rArN1Sx82KRyA==
X-Received: by 2002:a05:622a:a9c6:20b0:509:21ff:cd49 with SMTP id
 d75a77b69052e-50e254bc6e6mr2041191cf.4.1776279272758; Wed, 15 Apr 2026
 11:54:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415173735.24437-1-tony.luck@intel.com> <CACw3F522f6p-x6MEU8t7CEoU1P=PtU8dKy7opKjH8sOecdF1kg@mail.gmail.com>
 <SJ1PR11MB6083BF86FFA17D90FBF86686FC222@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083BF86FFA17D90FBF86686FC222@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Wed, 15 Apr 2026 11:54:18 -0700
X-Gm-Features: AQROBzCLembwy546Y5LhQ65sboCQA_VYbP6s9bHTxyGDzsDQtWuY3ifv6HzqkA8
Message-ID: <CACw3F51QuexjytfyCFZe6uRaWqMKbQwrG9qFCvArf--xEr-9jQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: APEI: EINJ: Fix EINJv2 memory injection
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Li, Herman" <herman.li@intel.com>, 
	Zaid Alali <zaidal@os.amperecomputing.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Wed, Apr 15, 2026 at 11:15=E2=80=AFAM Luck, Tony <tony.luck@intel.com> w=
rote:
>
> > > +static bool is_memory_injection(u32 type, u64 param2)
> > > +{
> > > +       if (is_v2)
> > > +               return type & BIT(1);
> >
> > Hi Tony, just a nit: for readability would it better to introduce a
> > macro for BIT(1)? like ACPI65_EINJV2_ERROR_TYPE_MEMORY
>
> I thought about that. The old (v1?) EINJ type bits are in <acpi/actbl1.h>
>
> So "the right thing"(TM) might be to add some V2 defines there:
>
> #define ACPI_EINJV2_PROCESSOR   BIT(0)
> #define ACPI_EINJV2_MEMORY              BIT(1)
> #define ACPI_EINJV2_PCIX                        BIT(2)

Looks good to me. Let's see what Rafael thinks about adding them.

>
> Rafael: Do you want that? I can start the process in the ACPICA tree if y=
ou do.
>
> -Tony
