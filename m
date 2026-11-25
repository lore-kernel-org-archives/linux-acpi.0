Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795629810;
	b=a6yITH0Poxz46Drlhn7MsIyzm/c+NluqWemZMN9k/1+MVFWB/Wt8CjPUMH3OyFDsVtoU
	 qubHwAL4cbwsFaLo1ibZahOmDdI5RujLfWVt44yiD6eDIE8AXWMYMKUUI7ld3P8PEK81O
	 j5QM/wciH5Nqc8ROQhZR3rKmazZqHDrnoAXh4iBD+JxZmy0ZmS4vqW6aeGo7xwj08SVsu
	 CYC4RQrPdk+p9j/doFEZMM+vbVmQ/jarNTw1lEbP/0lD9kPiY4X0nPeAdnM904dw1kYrT
	 I53hIFG0muXE1UK1QILZNWPO/6VlyKP0UFqqIhn1VRhrWcQNvKVn1qgk34sX19N3wDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629810;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ednzTerZKQHbSr9weSnkbZGaI0lxxyuNE/iWCwgD8eQ=;
	b=5sVX3JiY9w1FFAE6mnTaoiZd34uMqNrjuWnIUAP2bSl+dwffn4sL3VWDYqMB1h8wbIs9
	 ilCVlfpWNB+BUS/iDo/3NlXIYwA2cD7+vew1Qy5gMIHN1IQ3CHkwlth5osrgj3kjx4O6x
	 QZwnMIwTpjE1tAXVYltAfX8Ph1piIQ080zYWhewFPobWkXXVCVqMB1OJauxdy2Wh5bU1v
	 IQSekh2aAkA5m3PAUF7whWg7KB4OW6aAgupNvbX4BAUj/vILBRdnyJADIeXHyeBKGx4Kr
	 ipyR8dej4RsKTbXvxS6A+JIb7Vz0aVye+yUoMlM/dlowtwCo//xjPoA6LKeRIyBvyfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Utu5jKWE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B733606A334
	for <linux-acpi@vger.kernel.org>; Wed, 25 Nov 2026 18:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B733606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Utu5jKWE
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-67c0bd676eeso4337393d50.3
        for <linux-acpi@vger.kernel.org>; Wed, 25 Nov 2026 10:03:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795629809; cv=none;
        d=google.com; s=arc-20260327;
        b=JGlhTeKBF0WOREXh4LAjZ0xVPrwI3KDDKg3wrVUWMz3KwvK+RmI+S4/TtWv2DWQ2Hw
         XfPKTL37VI3WPwLBTSqE0vv7IbmX8YNCQy819MPoPgvHx2ItWe2ckgodh6oWLpYbTjNi
         w/hvPMQvMG+8OYmfLU4zDxaiis383NtLi+npWRQkgIRSSzP76I0DInqQU1h421ausaT/
         RFw0RRA2hGpfMy5rmCAU30+IHAWbH9ba4+NtGp9lqmkVcEKEs0khUUihEjpJqZPaNban
         0F8HoCTY5aenVNxF0LAzIeDI9gBHT1eD9KtjWkBXvQ89+nQT9B37wdufsgYJcAODrfWX
         zGdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ednzTerZKQHbSr9weSnkbZGaI0lxxyuNE/iWCwgD8eQ=;
        fh=aXaVL+ai0ebCjxANNfoGoY7o2ArkxJ5ceRv6SXwSd9Q=;
        b=cSxDuamR5X8Mk7Q3Fb0J1tjF49whJZ/nJWxa3XolrUhqXS9xYM4MRDmDkfdoii96kc
         x4gd4sQPX8l3LByz7MeRyy6aLiAgIVVeyTdg8+GcxTq79ADzUDv4bDxHUHiZytNo1Bz5
         JL16uu1WYiiNuas2hXlFP3uieWWgDX5wk2Guvm7UE3GKJc5iDP/agKXgeNNkMZqNO2w1
         rozgKsIRDLP189870RfzSyo6btxpfyl4PXaWoxtyoYYD9VqEi30cyFqCfB0VFSzJMFxT
         EUyKRLEjhnDjodNh2CUUq4x7ZkY4uZrZd0VQxAso2OIqFbrjFG6BNym4COgXXjM2PY2V
         7eGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795629809; x=1796234609; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ednzTerZKQHbSr9weSnkbZGaI0lxxyuNE/iWCwgD8eQ=;
        b=Utu5jKWEGVIdW35vjoBuglbD4NrMX23BcDFTZcJWrrMJ3d2BRMRGAThzxlSxiCojHd
         q5uOLfCrMA3eZnVg/MCWfE+dUcrMUbMV4+UcpUH/JM9erURiXwa1ilXIJ1XhiC+Cd3s4
         txrDqiOiE4HSWH1wNyFf/pUWa3NxRHWxZiY/W4QWU6XzT3/ttNTKGRXAKBAWrXSYZd5j
         OGa1e8Fe47nAvuj8JR+afsvzSk/Kc6o0dWyQeaA2JND7UiumCEg/ZpnDcLydLeWosxrw
         vjNqhzym6IABNJBEOFLcMEG+jtdJQE1VRhi5j3KvkQpPfn7LyMwqnqhR9mODKxATSjwv
         oLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795629809; x=1796234609;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ednzTerZKQHbSr9weSnkbZGaI0lxxyuNE/iWCwgD8eQ=;
        b=cna8fDgquJN33x1tFvXmMmqUqMel4XjTuIt2GmVpi1VaeJaDh+CIfmkd5ShrdyJyn2
         mkQk9zkA3eYn+kaYzpEhg3SBo/58Klgx3InvvaOdANX1PtMdAb0NDzyLiY6h9G3/Bd5N
         hnzPvop6jyXbsNPvgTLajXMI5uRD83Cqkd9yZuRoE0Iens7ZoXYug+X9c9oTI9pHux+V
         YjmGmLvQoGfNLm/4Y+Rf3b/EiJ8/EgLdgtzWZKRX0BIjNbzGoCQxwppsor8V5rJgAkZB
         bX4VgxA6SYvs9YJi/cdJugXTgFEtqdHKpo69yxy2SueeMdnVXp2uQaWW2ZHot1Z29x6p
         NmFA==
X-Forwarded-Encrypted: i=1; AL+hErGRJcr6pU5saYKN5KC5fp7G7F37QZnvRzllN0lJnBhxPxnllUwQsW+xPYrh9Bvp1v9dDc5j6mjErupN@vger.kernel.org
X-Gm-Message-State: APuU4Z/G6pRiNXWQQdDehLGVMvB34HF8pSAJMRx0QmMQI0KLJWeKEp6o
	S+YJ6KPGYJo6ZBVL5a9cBWDDILO4Stow2rNUDmaUYzVbVYCO8LDlcWLcOJCPGP3+qZOA9LbxQVL
	Xma0HGtrCzP3bo3efcHwH9i16U4pjhKQ=
X-Gm-Gg: AZFdTZdpjdV0PNsFwTlbjzMjrUcrL3IjejEqFPcah11/JjNmZ9Bixc8kYDngcWKT20C
	r/w1foa/Gz4uM7eVMRxHCzsaS00HRg+FZKOEGGb1XjTb722N8vVNVdTowgmtooO15XZexWL0KXY
	ctUFigubrbynPq5mgm+nuj6HLTv16nSqsFeyAG7tYKfKtWxVuypkK0XUufFqcYqRxOcGMZCMAWN
	ir3Hm0mIdLEXrlZmKaaJvJyWVKjSSg28brgn2ofpGp38m9lbXS5PwggpxRjrGeHVOluScD/QynA
	p4WneaVdJ5wlNRA5CvkHaJmv4hPPTZFB3T8bXQPW1cxfoHC4inKZulRN+AL+GoHZVgvJGTnVcW5
	izoz6uTsRQHJ9785Lgqeorl7X9zJO+l9CbIaA
X-Received: by 2002:a05:690e:4849:b0:67d:bd5a:cf4a with SMTP id
 956f58d0204a3-67df42d0aa2mr4895252d50.5.1795629809087; Wed, 25 Nov 2026
 10:03:29 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAMnz_-Dgg2eCgZxcCaGuKPV=3-kCfg7ajd9w=vs2fGL-Cb6hvw@mail.gmail.com>
 <f1b7d729-771a-4fba-89c0-996a8a168126@linux.dev> <ce46d69f-2a3e-45fe-abe2-f643f683d09f@gmx.de>
 <CAMnz_-Dztuj3CRsxcVnfe2=OCB3tTJzK6Lu7-AKfkbuqn5N-UQ@mail.gmail.com> <DSVPR12MB66402023AE5250384B26515942BC432@DSVPR12MB664020.namprd12.prod.outlook.com>
In-Reply-To: <DSVPR12MB66402023AE5250384B26515942BC432@DSVPR12MB664020.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Riccardo_Zangh=C3=AD?= <riccardo.z.dev@gmail.com>
Date: Wed, 25 Nov 2026 19:03:18 +0100
X-Gm-Features: Aa3M54o3ejowZkwXNaB2whcv1q9ei4v9f7X_tsdIHarYRrDqpjLNLgFm4DNkp9Y
Message-ID: <CAMnz_-C02J6CznPD68GgWCPCWEDSGsq6hoC+AJhsZjw39H+hhQ@mail.gmail.com>
Subject: Re: [BUG] ASUS TUF Gaming A16 FA608UM: working backlight device
 differs between MUX modes
To: Daniel Dadap <ddadap@nvidia.com>
Cc: Armin Wolf <W_Armin@gmx.de>, Denis Benato <denis.benato@linux.dev>, 
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "hansg@kernel.org" <hansg@kernel.org>, 
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>, "luke@ljones.dev" <luke@ljones.dev>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Nov 2026 at 07:13, Daniel Dadap <ddadap@nvidia.com> wrote:
> So, as an experiment, if you could read the LSb at physical address
> 0xFEDD83B8 in both iGPU and dGPU modes, and report on the value, that
> would help.

Hi Daniel,

Thanks for the detailed analysis. I believe I received your full message by
mail.

Result of: od -An -t x1 -j $((0xFEDD83B8)) -N 1 /dev/mem

integrated mode:              4a  (bit 0 = 0)
dGPU mode (gpu_mux_mode = 0): 07  (bit 0 = 1)

So G40C does differ between the two modes. I can try the DSDT
override next and report back, or test any other patch.

Thanks,
Riccardo
