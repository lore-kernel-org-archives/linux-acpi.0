Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAAE370D6B
	for <linux-acpi@vger.kernel.org>; Tue, 31 Mar 2026 06:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774939960; cv=none; b=iikjTRfF6BtJSQj47ys0FotXOS/YwT4K8Y4weiOUUQrC0G6umidjsT07vn7tTDfTo+2NUUJqATT19yuQRGz3RSfiUhoH4JN80y3zVPLd33sPDIA26CroDK+JCHgQsktY4/xJWNecNboi3WyBiTEhNtPuaeMtGuJzLArL1UkR5BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774939960; c=relaxed/simple;
	bh=PLN12L/J2iyyWxe2If0sxXyHDGxdLInF1MDvYiDe6+8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=OKPdXf9TERRSalwUWxz4wRt7S2+nXcLMw1BmTViTkYyeSZ2rAbnXvTyfdcKHcTkxvH3lrP/0dZdsGCAf/sANaCYW0Ou3peMC9RiN+sAk4JlSgcAav1a6cDmqiguV6/BIUXrFuqwWw8xdpFCuOqzIgeiYxUxGg3p/W+Esr9NDmU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s5EGHAbL; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5EGHAbL"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12776bebe9fso114524c88.1
        for <linux-acpi@vger.kernel.org>; Mon, 30 Mar 2026 23:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774939958; x=1775544758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GbP8tAe8emnfrefImNYaY1sC/mYPUiQj77TYwG/NXDY=;
        b=s5EGHAbL+AipjSAgSeB7WCI9znxq1rUvXs4mogDyNSUffoW+Eg7CxBAXQDATx/nUyi
         5OXVlCJweyNkXqyQrBdjzxxEVBt0VeLNXH4hSRrr/taJ0/8w40p8TZAcl+jaArjDlz4m
         jbfoRwx6yAWognquBCPjaTm/X5dAykyd2llsQS/PZwFe9TvGEVy5iLLJLojeqsjYlK2r
         YthUC1WW6YY9xJuH2+0TaFFtwq0wh9AztoWLutHfaykWsGR/dXlOpGmY41otmNN1Cxks
         rFR1k+ChZpzsyofzEZPFYVSfGLlw3K07j3lfIdSQiQO42K/uMzxKbPUw8Aca99SQXkEi
         zBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774939958; x=1775544758;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GbP8tAe8emnfrefImNYaY1sC/mYPUiQj77TYwG/NXDY=;
        b=N8dUT4OpzAtfSAN51Xl566l6Aki9SI5scbhPBX/zy2RbpdckvDMA0qhom9DS7I5XKz
         QUaqmbBOYxXiJKwsIrB7sMg62GuLn9ulY0794PqPvUEzdUDbiJ3qU7E/WQ8LkCte3cix
         eAe1XMcGewLdz/LLl9KH76D8mfGljX97LkPue710eQxgd0wT56LcGTDhcyTeMZNTXgb0
         GaNpFMUnbruwnx1zs3zlICKFHgt0KYwYukIvMwskOUIqzmU2qsaBCh4X15dSjayqtE/2
         rbWjGNMqOOJP4PDFwltVPae7Hn6ZYk9FY+DG2jcIE5qlHYvR/yhy0LdU/buayJZe42SQ
         93eg==
X-Forwarded-Encrypted: i=1; AJvYcCVbGP8vOG5K8kU8SvF+JKjSeOgMLfTCgLx0tSsG3siU8U/8bnlrVX9cNjiB8Bw63X6vx0tF6nXalZth@vger.kernel.org
X-Gm-Message-State: AOJu0YxNbo6ky6t9FnVMQNCj6mvxCP12yQbvf7CEdtTYf1UPzWoXaojH
	7Y+JHxKZ0i0Ndqtnt49GL4wddd6mwRvtzK05y5R4rEgxKQqys5herwNO
X-Gm-Gg: ATEYQzxItPJ0++jkSqIKen+ehNKanXXqThYVbEuFKJfdVhYKs17N49q6GmGmMro3eju
	TzNwwodFb3KTGN4yUh0elLv8pU0HwUMohPYvoWo2UdEt2uxLD+2UCCn9cecjkJwSItaYPIbNfUd
	8XtxT9nsxHVJx17v/kqy1x3b4f5CwL9Vj91opEGfqb92QyLCenMo/+Dw10V+f0Ut+j6LYJlc0Bz
	nIZUlezccQYAwhnu6I3TA/3Zq8OnuM5q7DVKxxt7SIVYW5uqcWjyYHcpBXH2uzsYFkdK/CgTzR1
	yJF5tKMYtKI2Jb9xSBiPe0z9B2Ss3bC5McA3pjGaapgEEGWrRkTu6NSSteuJ43btn5PGANPrm0W
	MPJeFcNEMd5eda+4XDgvetT5EV+v9TeBEl/Z8f48aBSd8CF1ENvm/j3X7NU3S3hhLn9u1xEf+65
	bl5S+HqTSNeKjXUkNqIrqMgK3qdRRYqn93LbBXMXAiTAw=
X-Received: by 2002:a05:7022:4393:b0:12a:94ab:e20 with SMTP id a92af1059eb24-12ab28d8bb8mr9317994c88.20.1774939957860;
        Mon, 30 Mar 2026 23:52:37 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2601:647:5e00:4acd:7f58:87c9:ef3d:71ac])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab983f904sm13792148c88.9.2026.03.30.23.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 23:52:37 -0700 (PDT)
Date: Mon, 30 Mar 2026 23:52:34 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>,
 Russell King <linux@armlinux.org.uk>, Kevin Hilman <khilman@baylibre.com>,
 Arnd Bergmann <arnd@arndb.de>, brgl@kernel.org, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v4 2/3] driver core: make software nodes available earlier
User-Agent: K-9 Mail for Android
In-Reply-To: <acto3TE1AR8iTzF0@ashevche-desk.local>
References: <20260330-nokia770-gpio-swnodes-v4-0-b68592e977d0@oss.qualcomm.com> <20260330-nokia770-gpio-swnodes-v4-2-b68592e977d0@oss.qualcomm.com> <acrcDTPpXZ_5A4D8@ashevche-desk.local> <acruxMNdnUlyRHiy@google.com> <acto3TE1AR8iTzF0@ashevche-desk.local>
Message-ID: <DDF494E5-C188-4A86-AC02-265B6169B591@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 30, 2026 11:25:33 PM PDT, Andy Shevchenko <andriy=2Eshevchenko@lin=
ux=2Eintel=2Ecom> wrote:
>On Mon, Mar 30, 2026 at 02:46:45PM -0700, Dmitry Torokhov wrote:
>> On Mon, Mar 30, 2026 at 11:24:45PM +0300, Andy Shevchenko wrote:
>> > On Mon, Mar 30, 2026 at 02:40:47PM +0200, Bartosz Golaszewski wrote:
>
>=2E=2E=2E
>
>> > > -static void __exit software_node_exit(void)
>> > > -{
>> > > -	ida_destroy(&swnode_root_ids);
>> > > -	kset_unregister(swnode_kset);
>> > >  }
>> > > -__exitcall(software_node_exit);
>> >=20
>> > Why? What's wrong with the __exitcall?
>>=20
>> It's dead code=2E Always was, always will be=2E
>>=20
>> Maybe split in a separate patch, but I sometimes feel the idea of "one
>> change" is taken to extreme and adds to both developer's and maintainer=
s
>> burden by needing to keep track of extra patches=2E
>
>Why does __exitcall() exist then? It's also used in other places=2E
>I think it's generally good to have a possibility to clean up
>after run=2E
>

The code section will be discarded when the kernel finishes booting so it =
only increases image size on disk=2E=20

>A bit of archaeology:
>
>The first time it appeared was in the bcc2152647b8 ("Import 2=2E4=2E0-tes=
t3pre3")=2E
>Then somehow spread a bit (but not much)=2E
>

And it shows how useful it is=2E Maybe it had some purpose a long time ago=
, but at present time this code will never be executed since it cannot be b=
uilt as a module=2E

Thanks=2E=20

--=20
Dmitry
