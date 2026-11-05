Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915318;
	b=xSZHCScKhMIK56mJeIRS/Ylgan6PlhZ9VEzxKoegW3lIZkeP7v9afGHfbZ6s8Xfpdo0d
	 gl+eVCSof+7W5gggqWrmx4dmwtEoqPaVTtiSUgzc6LJuwZ7th8Wqk1ySwQndWNTQ4DNPN
	 I0J0aLOXGMJsMB24B581OynzVX+nVIWWHpj0ucqFwZ4ceGcNEXSplKkqfKjlKNCc7WnKI
	 UghIbbkufjnHJreU/GiqXKqLjlZdbeVku75yMSYdhmx6llSZf19vt0wLBYX81M2nRimcr
	 sy+n0eO1708OkwRqSpMd8VaoR39Uihm/RSDPrSEPHf0lw58ogKjhBenqFT+A9j3v6BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=l8n+OopgLwypxqFGetb5HIgCgsMRDuPspITkC+2T1Gk=;
	b=jLYgL07CMULrRHxPq2/+o9TpWHW5Z96d2jkqOW7OSCFDgGLrSzS4wNsqTrvytd7aBIxm
	 L2ivUHhbejnEokdx62oQpa63IEo3j53ubzpGVw3FsIkn9rsOsGWR633XhCS/H0AKGqXAq
	 boec1SaGdYk2Z8p0Jb+A2CE0LlY5GZGFV7RQo3/RHdHnjiVX+h6Lah6noiFANaFihxwwv
	 ZM8ZT6IBwqs6jt8q3hHLuQGGUL321rbxlCLBv6WNyELaxl0YfWQgNHRKNUcfiedxZv5SI
	 cmwfkockclMDPYx57V0m2ZCUMq0hVY0sF5L4VRePWyF3UShSyb7pHFWIENr1yMud/tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=GYG6ANvW;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BAF606A326
	for <linux-acpi@vger.kernel.org>; Thu,  5 Nov 2026 21:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1BAF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=GYG6ANvW
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c34bff61551so113705666b.2
        for <linux-acpi@vger.kernel.org>; Thu, 05 Nov 2026 13:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793915316; x=1794520116; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l8n+OopgLwypxqFGetb5HIgCgsMRDuPspITkC+2T1Gk=;
        b=GYG6ANvW8yahXDU/pTBi7oSrLWIjSfviQLzqNss9PeKHJqcnNlN43kKhIXi71bFcRU
         SWOOCSE687gYqBn3ISNFzXXAo6dGSGmypKyGLGNVgbpnfB0P+6wnPMqGaBCGnGh5jJmm
         V9/9P8+GPlpbKzI0IgyGTW01mFLJGBb+kMJPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793915316; x=1794520116;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l8n+OopgLwypxqFGetb5HIgCgsMRDuPspITkC+2T1Gk=;
        b=Z4bV/eIxc0k9yhRlwQiBcAMG0vjuiLnvAvYQHizsC0PW8fn9hXY2qMWBVCxCOzoz1U
         s1g4ENT6S9LvTkfXjAT4pZr4bt+biUc2sjuxqYHdKqATY0H7xsFlgkWozb63Xi0SNgtu
         I4LSnGGsDVWOFNh6bRnoBENTzjQUxEH6yiqIHzRTSy6UE9fndPj/1rRJBWwte1ESaInZ
         0TvPAQzsEJYRs+sQuLf+BYQDyG/12oCB3Jqq+H+ROnwQ8+mfhJE0WRc+IFt+yGnKjCH6
         563cX6bPeFUEypA3Tu6CliIpQeesmM4vCeHMxUAuRm3c20Y67jAD4IbyvXRW+k0jB24E
         lfMg==
X-Forwarded-Encrypted: i=1; AKwUvByTh7U71WpzL6frk3sKS4ZAsOj01JUtKJep6aCQ3WQkExwuSfqwfh3QMhJrnRexFhyyqg0FEcBkej+0@vger.kernel.org
X-Gm-Message-State: APuU4Z+EZayk9dwuR/uVzx+lAyS5BcfoLuKaFZ+VF8374ddRsBVHuakW
	b6fo5jnk0BbIex09RwpBxkSjaOSFmzYtdShRpKo8oSeg2LLc2EsYMd445SG5bV6jVQeiOcU9p+9
	uyd6we3o/sg==
X-Gm-Gg: AYBFou1yt1ZnyvFqCL8Dhxxeq9SItDcRmPSzUayK6sr0Ul4fWKhepqFzd/YIfk3OHWA
	UxfxJUlozZo+fhtedDoA5B/vSCRS4jNDHKnTpT1FY98jXz9YT8nf4F6kIsDtlYm4Ti1Ax9FcILf
	NV5ZITr9dTuuN9U+aTJD2b3/j03eIZBHyrU2Yd19SPPFRz3crmQslW8Zs4y1yBRE0dlRrnJsxa0
	uQOMEKYpdLEJV+qhjlAI5bY5VtZw7TCo5n/5KwsguJQt9mOcsu1D7l4+8pW+QaUZUe+x4NNTQhk
	x+7BpqaPFOnRJMOaGTMwePSqFhXzhU8Oso/ThMUpGBT/Euy8uLgrM4dm9Hc0s42fAEp/LN1B1vm
	xQN9Tyn53QeymImmKyLqXf296kIGYT7HGCjuJBwhNu5mSqfj40bcaKTmA74xeDmo/GxtsgObjpT
	RBjqxEV1HoWpY1s1QzvsjiW3n260K+gjmH9nNwpfCKgxg4bRIYENSq6s2dEXmJ6c/ZtbjXhkn1X
	++Z+myPt5gu46JOpzLin2r81jXWwUgPlv6aRzZjlYB9cruAlUlV8vDwNj1AkABGEGlK1cBtB9ca
	/e6NacY1wYIZgtWpeX/1KqJcSwOodwqtRrqX+NbqcBQCaV4HTYQRet3//k8zifCE61FlMvXw+eG
	1F4UNudTWc93SztC0ZSCMdkE=
X-Received: by 2002:a17:906:c156:b0:c2d:bae5:27d9 with SMTP id a640c23a62f3a-c4d34d3cf5dmr65931666b.46.1793915316057;
        Thu, 05 Nov 2026 13:48:36 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d354ac21dsm20666866b.12.2026.11.05.13.48.35
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 13:48:35 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c3fd91337baso112753666b.3
        for <linux-acpi@vger.kernel.org>; Thu, 05 Nov 2026 13:48:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByFA6RjGqJwkzQ4BcOwIV25CD0g7/OwY0jvI4GYdQVlHeqnOWYE+WM9aeB3rFdi85Ng4FNfCSHzud/W@vger.kernel.org
X-Received: by 2002:a17:907:2da2:b0:c40:b59:1b with SMTP id
 a640c23a62f3a-c4d34d39a58mr58567866b.44.1793915314942; Thu, 05 Nov 2026
 13:48:34 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793876837.git.alx@kernel.org> <9c81f6f62fd0e908e683c4c08b09a1f95bc2ec9c.1793876837.git.alx@kernel.org>
 <20261105111423.360f4ba8@gandalf.local.home> <auyuINXEJKc1KoG7@devuan>
 <20261105115019.2fe7c91b@gandalf.local.home> <auy0O467UqOzqYub@devuan>
 <auzGMV1YbO9DodBq@ashevche-desk.local> <auzHFRzd86iV4-RA@ashevche-desk.local> <auzxXyAU6zyHtMtn@devuan>
In-Reply-To: <auzxXyAU6zyHtMtn@devuan>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Nov 2026 13:48:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjD-fQvBvozu7+TjXa4=arAFgVzyixw4W_A=14Y8rhSLA@mail.gmail.com>
X-Gm-Features: AclHuK9v-o21t8pmiI4INk2NQJoSrOcmPCpk8IDpuzUs81f6KLpwaM7gxXogW80
Message-ID: <CAHk-=wjD-fQvBvozu7+TjXa4=arAFgVzyixw4W_A=14Y8rhSLA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] string: Add strprefix(), and deprecate str_has_prefix()
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, 
	Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>, 
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Nov 2026 at 13:24, Alejandro Colomar
<alx+linux-hardening@kernel.org> wrote:
>
> I think it might indeed be that find(1) is slow at filtering, because
> using git-ls-files(1) is faster without piping to grep(1):

No. Your find | grep" speedup is because you use two cores for this.
So it's slower, but does it in parallel, which is faster on a machine
with idle cores.

The reason git ls-files is faster is different: it's because git
ls-files is just that fast.

And it's so fast that now the pipe overhead is much much more
expensive than git itself, and so doing "git ls-files | grep" is
slower and only adds overhead even if you have idle cores.

And the reason git ls-files is so fast is because it doesn't do any
directory searches. It just looks at the git index file.

So git ls-files really does something very different from 'find'. It
just looks at the files that git already knows about, and it basically
only opens '.git/index' and parses it.

You can *make* git ls-files do a directory read: if you ask for "other
files" (with the -o option) then git ls-files will basically do that
whole directory traversal that 'find' does.

Anyway, if you search sources and don't want to care about object
files or other generated files etc, I'd heavily suggest using "git
ls-files" and "git grep" exactly because it's much faster.

(Ok, "git grep" isn't always faster, the whole regex algorithm issue
can go both ways, but 'git grep' does do the same "just look at files
that are actually known to git" thing, and obviously it can look at
different revisions etc too, so it's really *good* at greapping the
actual committed history, although if you go back in history you'll
obviously be paying a much higher price because now the cost is often
not the regex, but the unpacking of the objects etc)

            Linus
