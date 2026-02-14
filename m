Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B550E257431;
	Sat, 14 Feb 2026 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771085687; cv=none; b=gKYmqxfv2v3PGj0o5Zn/fmply2H8Lbf+kw8dwbpzMWs+fFaTcGpdgOlbYwLiiO2Tjif2hONuNTtY9wuWVgMFoP2IDHPaRPc6l8T9yQ23Hmo1qx1vKxhoRYwjnX95zWEFxGkKI2oaW+zHAY/KmpsuBO5hf1DeVtGg7hQ5NXB5qEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771085687; c=relaxed/simple;
	bh=2TBSiLve077Yk9gwpaWF6Sq6swx35/UlWSSt5RbGcEU=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=HlGbLCRli/lHzZEA+hPvEgGXNB9Z61zI1b9zfvJH1nMGkG3ItXB39EtbEaVlI3mQrff1/1chUA7/0YAtvWoijkY7IJR/bwVtPZC5lU2gaDF/fx1UP9gOvLrrVkhwKbvG/irBPwJ+HABlXeZIrO4CWN5GMnwGjBrRk2BnVxyRcho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Y1GAiBBN; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Y1GAiBBN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:To:From:Subject:
	Content-Type; bh=es+Jw6amFVZ84lXSThkwVU1vFUqF+EEP3BsfUcmzkHc=;
	b=Y1GAiBBNBhwWz/1DcZ/XureluI3v/VXWum/biFzPchg8eyEVYKOUb9d6ZJxiPF
	r4m6DoMneXH2C0KxLR3td3N0MBxN27NMUgW3KelvNZsyDXr4eJnIF3wVk9B4BWvo
	lpGEeB8DGovtKbsBNk+C+RpAlsnzl2C7v/r6R97eQ9+LQ=
Received: from [IPV6:240e:3a5:54be:1131:4873:9716:4d9a:3] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnVw7ZnpBpFsq5Ag--.10328S2;
	Sun, 15 Feb 2026 00:12:09 +0800 (CST)
Message-ID: <d0785a7c-7e4c-434b-af31-4ec6f690ed89@126.com>
Date: Sun, 15 Feb 2026 00:11:35 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org
From: Zhai Can <bczhc0@126.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org
Subject: ACPI: PM: Add acpi power resource quirk for THUNDEROBOT ZERO
Autocrypt: addr=bczhc0@126.com; keydata=
 xjMEZ8kf3hYJKwYBBAHaRw8BAQdAfYv6FjQrbU06lNnLPvfMiD0SY6GA36LmS4KwI6NGpYzN
 F+e/n+eBvyA8YmN6aGMwQDEyNi5jb20+wpkEExYKAEEWIQRwMaNgGMPoLiWbYoZASF4q3tSX
 GAUCZ8kf3gIbAwUJA8JnAAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgAAKCRBASF4q3tSX
 GE7KAP9Gk1RLVISsuqFHd9Am73vVdDIjy73c2qzsIvH8SWTRHQD/fit0wHKx211uZLKGEuJ9
 JVOSZQ+Gx8mwp2ArrsQRigvOOARnyR/eEgorBgEEAZdVAQUBAQdAAk1VnZH+OvC03jDsZALX
 Rj1OrEkmqrCZPi1K4Qsr8woDAQgHwn4EGBYKACYWIQRwMaNgGMPoLiWbYoZASF4q3tSXGAUC
 Z8kf3gIbDAUJA8JnAAAKCRBASF4q3tSXGC8GAP9Ous9awMCN+2OG9Qu7c3tc19Tnh6AlmsQe
 bbAcJ9jYyAEA7m7JYfqMkavU4bt03XHPPsAyzo2By8wOfld8/AeqIgw=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDnVw7ZnpBpFsq5Ag--.10328S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CryxKF4xAF18tFyfZr1fJFb_yoW8CrWfpr
	WSvwsxtryqqr18tFWDCa18KFy3u39IkFZ0gasrKrsxZ3W5JFZ2gr1ftry3Ary5Ar1Y9ws0
	qr4Y9rnYkFWDAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jw4SOUUUUU=
X-CM-SenderInfo: xef2xuaq6rjloofrz/xtbBpBtcW2mQntv1NwAA3G

Hello Rafael,

Since commit a1224f34d72a ("ACPI: PM: Check states of power resources 
during initialization"),
on laptop (Vendor "THUNDEROBOT", Model "ZERO, Board "NLZA"), when the 
second NVMe slot
is occupied, then during system boot, NVMe slot #2 plus the NVIDIA dGPU, 
will both be turned
off in `acpi_turn_off_unused_power_resources`.

This is reported as an issue here: 
https://bugzilla.kernel.org/show_bug.cgi?id=221087, for more
context. Relevant attachments (acpidump, dmesg and lspci) stay there too.

SSDT Override that nullifies all `_OFF` functions will solve the issue. 
However, I've found commit 9b04d99788cf
("ACPI: PM: Do not turn of unused power resources on the Toshiba Click 
Mini"), which I may
believe my case is quite similar to it, or maybe? I'm not familiar with 
ACPI so didn't dive into
the dumped ssdt table too much. What I know is, the ZERO model laptop 
has the `PXP` power
resource which seems to control both NVMe #2 and the NVIDIA, and it gets 
unexpectedly shut
down in `acpi_turn_off_unused_power_resources`. Note this only happens 
when NVMe #2 is
occupied. Specifically, if NVMe #2 is not plugged in (NVMe #1 can be 
plugged in and has
nothing to do here), PXP won't be shut down, and the NVIDIA dGPU will 
work as normal.

The following patch adds THUNDEROBOT ZERO model as a quirk - do not turn 
off any unused power
resources for this model. During a test (based on v6.18), if no patch 
applied, power resource
TBT1, WRST, BTRT and PXP (yea, the "NVMe #2 + NVIDIA" one) will be 
marked "unused" and be
turned off.

If PXP is treated as a sole exception (that is, other three are getting 
turned off),
during my test, didn't see any impact. However this patch just leaves 
all "unused" power
resources on, which I'm not sure if this is the best approach.

Please let me know if there's any thoughts and suggestions.

Best,
zc

