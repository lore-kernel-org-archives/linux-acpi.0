Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0625527592
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792072075; cv=none; b=RsoHDoY5tMBfEK3xfNezfr/PrzndS3y4/cQd69bBGW9Q0iuvzKut1rSQpg9lHv0XINupNHqGEeP7OW38ZOpKXyaHosHGHmbFlKPjTRMKCyHd2YFH0wrwCyf2Y9tYmp3o243Fa8C+Jnqtk93/pWtsMZpB5bFO0cfv3nKTkSZMnuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792072075; c=relaxed/simple;
	bh=j55zw5viGxZp1pXxSJj+AkBUOD4ghpetwBiAyan2hnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7uYyR1ErX197Q04bK5zxBjDZ2Iaf+u2q/zFGpxBohs8RgAZMeBXbzpQDp9WDy10baWL/2h+Kr0Of2AdnSCd5iPzJ5ZUfErzExDfhkEt4uZjPIQFVrdIIUJLKLerNM2VuHEJGqNqFiKUV2EEXIWA4cI1oqVdPlTz9sImG5A7lcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUbuH08q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUbuH08q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03A51F000C8
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 13:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792072073;
	bh=g0/qpdrfy/Oj2jhQu3d7Pibrb4+olgpm2ZjNSrruXrQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eUbuH08qiYvnc9cxPyONkuoJAtkQS6uILm2e4x6d1oj49SsGu154MK4GTGWhxXSHJ
	 3cxsQhdmtYEzaLwr/2EmYruyEXlyTgZ0zDjxOWWxlJSLVHXT/GlnUCNuk7m49W8Lxs
	 AQnh9JvmJwpWPyVbrcv6QGiYI7ql3Sno+MMdVpzP+Rqe1NEtr3YzkVKTvj5ZFtjalK
	 wTNHZqZd+ZZzxk/skEATbuTZ1+msLxAjcqYFEoX6lLgQxvleU3yfhvrvC1FYO/dqUO
	 s/veGeEciRoH1VpmVJ2t7OFXHh+5GWlL56g20mxsyHGgGgOpz5JtekQ/P4K2FxgVR2
	 3X+2O5tBagVpw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5be3d5927ceso609727e87.3
        for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 06:47:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByKFai6+7wAcLwVUX33r4H5Dmvz5VOSj9pFH1tgSFPJSIwLzg/eLahAyDHHfVY2JCc6qQb5oaOAEGUn@vger.kernel.org
X-Gm-Message-State: AFq9FYI0VnVDi698M0RxQsFSw0A8fMdW+BucLfzNceDVUY6p7OyPLQbS
	XTau51I/tdaDLXzHwzDh5r+rhYoE4HYz4pCkxCoW5u2fBNOpHsDISkuB1bAGqUOZyOi+zWCGF5w
	8lnWWLRwgZdVEw4EuDt2P1sZLwKRnHJs=
X-Received: by 2002:a05:6512:3091:b0:5bc:cb78:b884 with SMTP id
 2adb3069b0e04-5bcde8c1270mr5845776e87.41.1792072072088; Thu, 15 Oct 2026
 06:47:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014132703.93355-1-aliamemis@disroot.org> <24b2e368-f0bb-484c-bf88-b9ce3125180f@oss.qualcomm.com>
 <20261014150537.121547-1-aliamemis@disroot.org> <08b6196a955faef9968224d7946ea5b1150f2ae3.camel@rong.moe>
 <20261015120902.15337-1-aliamemis@disroot.org>
In-Reply-To: <20261015120902.15337-1-aliamemis@disroot.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 15 Oct 2026 15:45:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hEA_Pna=So-jd77OhaUEO1-Y6bEVFVMJ-bGNeziNj1kw@mail.gmail.com>
X-Gm-Features: AclHuK-LWYktE4aThDeFgwzeVaOyAWCAYG2t8e1kKUTnt2HN-pzsBDgg_CDv3q4
Message-ID: <CAJZ5v0hEA_Pna=So-jd77OhaUEO1-Y6bEVFVMJ-bGNeziNj1kw@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI: Serialize battery methods and INT3403 _TMP
To: =?UTF-8?Q?Ali_Ahmet_Memi=C5=9F?= <aliamemis@disroot.org>
Cc: Rong Zhang <i@rong.moe>, Hans de Goede <johannes.goede@oss.qualcomm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <W_Armin@gmx.de>, 
	Charis Stratakis <c.stratakis@proton.me>, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 2:09=E2=80=AFPM Ali Ahmet Memi=C5=9F <aliamemis@dis=
root.org> wrote:
>
> On Thu, Oct 15, 2026 at 07:51:22PM +0800, Rong Zhang wrote:
> > Thus, any call to ECCC or RDER consumes at least 200ms in emulation, bu=
t
> > in reality it doesn't.
>
> Thanks for finding the actual deadlock!  The 680 ms came from assuming
> "slow" EC commands.
>
> I'll wait a few days for Hans, Rafael or anyone else to comment on
> dropping the EC query and UCSI patches, then send a v2 that merges
> both series.

I would prefer to drop the EC query and UCSI patches for the time
being until it is confirmed that they actually help.
