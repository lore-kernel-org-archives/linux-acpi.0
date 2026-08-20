Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EA347DD59;
	Thu, 20 Aug 2026 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787245936; cv=none; b=p1wbXqnk6ndGpd6ZGf3eU0UocASwhKzhrsQX4ZNWFdwUjv2bRt+FebmqDwGkq+cVCpOaSALbgbWLt2n5T/m2aQ5vDiYm0cTelCIHDfsOG0lfwN3QgXD4xiq3IGNGM2qiMOqZ6PF5xqUS0zi1MUpFrwavZriC6aXdgZLeTSMKMZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787245936; c=relaxed/simple;
	bh=logZTgoziXemkIyl2wT67DMiyuMkjJILl+4d/DVtnYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8DIqcg2lIclKac56CrfB7BnsZmHNSi1fBXqTCVgdyDQmg50fuvYFo3Ny8TVctva53dXBdHsMQDX7mFVHAI7OmRKNXU48RneOqS5H8adDFemzwueUEVAT/z31g25HB/KqglIeK8TQ6MHvpW9g7eI8CGTYPWhPT9yB1X6PuM8B4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=AY3VBpsa; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="AY3VBpsa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1787245931; x=1787850731; i=w_armin@gmx.de;
	bh=DRuGgp1gEDaSfF16xlGrV0l6X4vuq69xgswKhqJkYVk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AY3VBpsaI+fFaImycbCTHBDSJiU8diBlr3EdNSxBIFu4A6dG1pMZzlBqN24Wxrx2
	 cGHcQVhavgjctTH4e17NfEm7hEuQwdzox7Kb06DaCCOD2xvRXVqeddM+8S00P9vgr
	 ddpCQtS3I5vMlNJzbQ6z0gv50Yn+384vUHZCeY+dk964VT7/5efxQbF3bIzoicfFB
	 Ie0JGzgq5tCiqpdc2ET3Fpj52DrN8YgWeZTdoKC7f+QlEEHatw8Ul1yL65EDSU1xq
	 1umGbmpoB+CrIfdSc9iApXsQSxhf5sjJ9+9A8ZobjYxcGwWvR/frlmq3b/bVbxBVB
	 CWGk4+MbXHcbgPGh6w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXp5a-1xT1IF0RKu-00NK0F; Thu, 20
 Aug 2026 19:12:11 +0200
Message-ID: <e3370699-751c-491e-983a-a4ae042980ce@gmx.de>
Date: Thu, 20 Aug 2026 19:12:06 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] ACPI: Updates related to upstream ACPICA project
 changes
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Colin Ian King <colin.i.king@gmail.com>, acpica-devel@lists.linux.dev,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
References: <7982261.EvYhyI6sBW@rafael.j.wysocki>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <7982261.EvYhyI6sBW@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:QpdlLR4tp5CfTrzpbbngA2r6fQWKpvpjDG2pvq327aAjTPJtT9A
 Wu9HHS21hZQQI7peZPg4yDPCmEQ/rRAF3V32uF53D+N5yQX6AYwNZEEuSZFF30Q18gZfcIi
 VTdYoZ6z4ny0uG7oZyheKP9VI9BXW5511X5RQGw5b2sEF8Jma3//iSDJNcyyYqsNoNKPAde
 n65H4hAsVxp6ww1K+/iRA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TZIsxrsqG40=;6KXdWq6RPkwyQWUEMkRbbyvbSkh
 EJdSMlDPDw6lQmzOGECFd3dsIVJuyi5x6MdFQoX0jcpz+XJAyENHSdEHinI4MinpjIkaO7aok
 GcfIVZMP6bmGzLfgJfMV19IC2JN0bybrbBTtexfz8BQxOa1w8ki4SJwnSYMa89nRVy1vYKVei
 pO6KsoUYMyL3DZMX4vCf1ACa/ouzMdy1qQ1D3m9OWf4D/AistyINWu/ELx4rHDGSDe3L5GFkV
 xRe3qLX1aU3E5duBtiVkk84vrV0U+NEQ2D9ZHXjWBYS6ziEwr50rrWOkeqtwNhl6enTVYeDoO
 hN4DBZKdnx7NsTMC2YU+6B5jOoLwY67W8jhlmrZy8PZkdnkKHYurvQ258gNik3Dh7favzV6Lu
 m7mWvcpANqjG+5Yafbd2773XlfmyKd5lj0kJ9p63orSbcpsCMTzKli3SIcXsiUXDJ0gKwl0O5
 pF0sbd5Xt/7tk2kvCu5dre1ZUuRkx8OO9yFJwoGfzsnfUHscRcpNBZqMbKfIygEkc7XCztqR/
 e4yb0oJkYEWeRnACoV5iJ1f+VFZkSGEGQU4YbrpS8lrXTATTxLsFacH3TWjLVKNYTmlNy9U5J
 31CbTC+xC1WyNjs+mM/h8QXpkp8HlblkrowQNupe3F/2yxSOCrAslQV7L2TK75HxY1Gt3ZDK+
 c0B5xBaVrUJN0Y2VOQmocq7GsM2y3Zxnsf+zCnPtFvvAMy1fKSxMVK9bUYKyFX18mT3y/nv8t
 UVvYuN0ZZgJklOVWLlIc+rSm/kK9dW+5rYNiEUuC2xyWhlm0VzPN9aJVlqUTvkI/UIuhn+N7U
 EU+tThfCHhoa9JLaUmQABbZP1JceXaGMrP4J0tNp7S183v7qU/LqztDgQVeExYVxd7lvb7+ca
 qDC2/Ke3cBL5dgYRHFxvkNkDB3ewWKFEwHS9eLV35gnUQKRPjDZFetvgrukSV9QMSSR0zIzGD
 iHwmMX/JzJurADfVJv+PfdDbSfWMy0etrdXcAos3GOtX0pyVneLi9qz1dl0R9jBYRUJNvo37a
 XizgpZOSk4e70QlBDIDrqsWEeS2PvIlTKXeNKu6IG8pUHU1bUOZTJ9b5wKyI5ZhTslg9NibPy
 RzCZ0LXEhAXf8siFVIhakFCDbAen/xDZr2GJiqrIUHVcKJDIY2zV8Yk40QXoxIBCOsECfj9PY
 N7UMGqLTAx1J8r5pf6LrjwoSYWFbytvy59J14b2vvuO4rY0eDiHgzykh2MvjH9aOiV0q86hcE
 dQ+jmBWlKEgUe6vOegQcxewFS1W1sWNB8V2QPZxpmYN3d/29LjOvpOTbCrlraacbTGleSVx9t
 nEm9UNpl8L7mjG5X1/Dd4pb4+cwMuigY1Ap7sbcDAFApiZ4l5LqAo4zfgqsRA+9iVioa5cmr+
 7exNNIPTDXDNz/w4Ynoz8aGitcbLstY2kAyN5LmnYzyX5/iAagwIQbQUyrqC5IeqiZuG4VQL7
 yB/i+Pi8c2/AI/L54SiL04km5Um4h+gJ0Ytla2zUjGELwuB1LLX5OgmjD7tWD024JR1DRrRKg
 aUio+RSovTkjusIvPilOefpEeqZ5KD57/91yM16ce7OFq30XPqRcpQaSieUOMWsecCndzgJV+
 PbM2y5HwBOYYq3gNNP5oG79ZkfZ76n7mKbJDD0TYYgJxW4foKlIpEn+fVpg+F+OCDcUt0QBGM
 yq541Hsw5AsPtk5F8CgTRLw9Q91jCijDVic5iEUA6tZshvmjxX4yYqbnprqei2U2BPVvz2LmT
 j0HDk3EzA2nIVzl+yla/Wizk1RXQbd63Y9tv7/UZnhviqbmHniQWTQlzC2WBwlBxtCMD/VwAT
 IN3Fi1wSFo6ZfugwysqfhQh+KSyXlpjOXh4iad95LY61ZpUYHXXbm40PxX8r8UAceKUh9ecww
 3LZRcoHoetWWvbzIMdaqTZTHrEZ8yBmM/hZoOAM7IPQdx1+8r7tRRIkYdvdaYll5QbesLzZni
 xUhEr1pPgueebNA1f6ZM7t/3kgbCS6vJ1u3axtOEq7D5bzH65mNsPNlg4MnyZqdDppE457c4x
 zEISQ3ZwP+ll8G4i2b9qnAgEcq+L8jd7Istkjg7ecy9XTtJwiItPkhqX+L0xOwXhhUabDJ9kL
 56LcXSArmkN4LMsJBZ7Pn2ppNWuwA1gJ88PRa5Mpy95s4QSnkEV9yGII/kxZrsERiCHRtvRK3
 DsrlFU+iZTaP7mcjQ1ATu1Bm2jGwV4e8mRCBy0MURuPus9nb0mNwd1c808HYR1I1Vd5v54VRn
 Px0hN7D2LlW0QeUjnVb6LV08FOg/hWIssNGMTDEEHtjLUvcQb+Fts4Z5qK8123yJw/JAb9XoA
 RgTwtr/pmiqZn1zHUfBrI0dWZ2QWvWM7edCzPxHj5Vg025xIbkov/2A4kBOpGnoSTUbxHITaR
 8Gzk60q/1mEBu8UyenFDc9hy2Ccx16eD0Id3VNJ6SMC0tyluFXoQJd1D0572ahlad2MZ7Dx7f
 Jouq2Efpe0nhaE7/6rvAqXnDOzzx+0PB6gSfE8G+GNo4iQHASmEWpVGOk9kbv7Sdw5fa4Fk3A
 C/gKoaUBlHCyqvm5PoGXEyrpb5wZYa1AX7YEQEqLUaQbi0EMLk2kV3gec/I2hft4DwLfm0H0n
 GZ5TSkJ0yBfqU652GVIHcjQkzRoqb5x2w6gJZWr5483ezUVu69Ogw0D24XWCXxvH4e/rgGu9T
 9uZamD9hiuOvnFgG7i+cmiJ9UViYa5bU0cHSAezsMeFIAmIYTXsnLEnKR+U3S3XysQwnRFisg
 W8nuri2zWHuL3bNTSXzeS4dAqLPiWv2KwcdGt7vi3T+edtzQTLkhnA2+jw+SF9I0QKL3dMm7e
 xKXNHl8Qxidq8LYLv2d5915s3XQGzvREPXMsIytfMbDU9x3fgbm0zXQhtor4AeWNN5yLnA0sP
 /skawJVLdrMKLBFPOvszQ06/9ElZerXcaSX0hrc3HKRaqJFq/fZRFC7NNY0ER0WFv35DD63ys
 t5N2HJSEhxDwwaVy7s08pkBwpYf26jgr4gnAdz1A0N+6Xp02JUbEMc58JBHBtz7iuWfHw0uP9
 PaqnSj6K2syFTYtfaWR62766z8QpWOXqRaEiHGaSaY46gL9adWXpgmI3fdvHizbo4ThOVkvXr
 Ii0ChYjFku/8l4jPAvsZkgF7zQFdSA9Sc5Im1Qx2dot0z+ika4am9Cd/LkeF6Irtkpx5Yj3ee
 hUGKoOJJ34sCp80mkzTscxaa6o5jZY6L5KwCbc0iEmevMHAgYtpu7BjTcZP/v3+nabxKGmtv/
 ht5pKZnCPku4mmRRSsapZSuz66LDwBPnkN5sKv9h2Tc90EA751hIPzAGz/Qu/x2O1hS4fi380
 gwC1MSbOnel3LlNE9U1oX44mpfJvfHtfo820/d7BrcMl/VNX7jNFT4aJrYTSxpkxz3raaAgTb
 rn6WR+ERQAJ024QPJ1ptD8olANphI/ANRCu/885vcuBLt0b72DEf0Bwn2TLhxKUaRPBPmrvKP
 V04lwWLP5AFRImwLQSm8o46g5r4AvWQmNKYEp0Fry2XKkgqFwjRlz8aJenAqff1P/ZJ92N/3G
 hiUFO+zjvdnDnYrrgeEKSJ1y+hkQuMvOd+HHt8aohKzUCJxp0WSMgZaSA5DjWC9rSpVgIaKGO
 bybPGdSq9KE3fs4h5OIFTf0OshRGGXbL9KZPHhCm/b8pyeUnAk16SCEaQKdZqarXNAPVX/8zL
 3TbhsV0GZo72URMXeoJPftVILPJyGkOkHP/7UAkjvBKJ52b8JoPBrx12GFQXqFur+1+dkSb4q
 RclLr5gmDxnjVp5ReP+unoLUJdscBWX40RYyz+LPH1TShqGkyIEz60RYPE1+m8ITSLtHN1tOJ
 v9ECq+sCy8hklIKoma101bsy/uAHrLHyRXHdDzB/wWg0qLfePyNFs5bum1cCJkzjKnHTR8WN4
 uNY65ff0BBJeGCLdv0p0a1ldRg/zFNMMZc0/Bt36YVbVfuH1a1UqpDDzpoR/rGc2qdlyeGCsw
 kWKLx8pHT+EAmrMwrxpNEK+p83GOSVRzUfzCHYUtWyl0+Cqa9tGhAdfJRyGvvKC3G0ZjutSHI
 93RuNJ9sms5BRHbYGJ73bCW8Gr0gqfg0btoofUuafW1UzmcEBhoRhvWmAfP+RSAviaGi18EJ0
 PDim/PT4z/ohWVFYXBEacN1SphSMnjm7ThiPcfaulqe/yVjCVQD+iiSrivBxnfnQ+dmCsRhkN
 tozAJsLe/TcpOhnLPVNM22GpjiJtRMutoGaqBIUYlfHnFQtQXEdCgFp2QT/NNmkXMk/exCzyl
 YfBaQ+MBIjXUYslO8c3bcxhD8H+WhzUSccKQh6ng/S7ZQnYV0yqVpUXGxz+JyolY8FlnwNt0P
 R55B4AdmC9zww++I7jzy4FfnbpIv/Hdupd+vwoj8oENtGfFeiqS77lEotbsGdTZTrV2zmVqyc
 TA43uL7wtcK+mWcuroBpwRmujkA/LCIP5wpdSzPS+gtiPpYujPWn7gViYLYUz6/THSNFr9yZn
 3k48ZgP260guTj49CUowEl2HrjxRsu5ISxeAex90w53zufbnWugpRLutK2HU734CB83we/W6G
 On4Mg8gz8SzSSvPs8p8zjbHnBqZcdp5e4mCFG37rdSbNc/pALIEReFbBayX3bffqFKRXYE0vJ
 5+LyqmS69dq7OMUwDdowAD4WWwrB7alVWH3KpbkmM5OZfcxEaDBNH2KB+SxLCmbnYL6eDWgpW
 syTZB7dyK0nDKbyxCD5RkoJhWuoNCYasDcQ9u88zHgiC7ewlEc11ZIqYs2D/cppAdbna+cy9z
 CeXiZ+JFz2tCrMEkUJrHLxukKkCp6thxysz0g82bW9YTwy/QVsa8wZeOxd/wQhN+uroRLBfdR
 m5iuW1mAMn8SkfXQ3Es6WWHR/t5vwJ46t8bQMwHIZsG85PQahn8lB0t2/k9LOtKGTewVlvPH5
 AaiWKM1Rw/2HubC27EYEzYRhGjNJlO8xtzsdDR4V6NqJPvvMuU453by55l2yqGSwpP20wn4aB
 n0SFIBtUg+4GMdhnD6CH5EoM9sqDh6jmseQ73vJT4JkiE606ds271DLBD7PkS2go542I9r14m
 4R86oEkg666xxqLwVMdvCKZNNq4TnP+A9vNeRHpfT62i4DuyCtYkRovAITM4qFzh/ZPj1xoQe
 V01T75tv0hzCmpBiAZCgVXgZmieo08ZhAfvF0Yd9GLt5DAfTnfyspusT2llAE2aam0fp8Ia+V
 k5sNBZKRt2nqXycdvR1p91fnhENeLfxZ7XQL3eZnlsgMxLm0mV7/NUa9qOQxWkJ+40tW8rZnf
 8RaitaEIVoz/fTfqChmfaF6Fl28sNaSOqJWPW4dZ3knFxtx5ng/2weyhtWdMvb1GQUgogDq6i
 4lmC4clYr+BDcPyhLbP1IAC1KHjuSlS/mJtWoigmJArDEez0NxbZY8CGFv12EjYAO7gd1wF6y
 0lTov19yboRkq37ybq40c3QbGsFHEniq2keI3kNXQjx3rfHkTdteS6HiIbVMkCKwSbqSjn77i
 BYoUo2mrais69my8cW929RfktzXU0mz6OnxTvGuaRMYbjOW7jiLWyag47CVNwsT3KY9T8gmke
 Cm7xfBzFeXbc2OR0xgPfu60F2+GlUUJm2vkeSXv7xo7Ip6GnRvgJkf9gdWj3aK0mrSdUrAMeT
 TTIwKtbGvbUm6ghl0yOsh6jB96w3b02sVcvpUNJUnABayrdjOVj0oTSiGLPsi/PLqdHB2Qd6T
 4Q7uanGLI0o/lTtnbCB15rW6u+8c3frlHaTt03xNMslwmt3pj4xJPzr3CBG6bkbf4RaCWs12j
 OlrfOjh9mqCR8a1QNEmzKXv3RIu6CgK3tlR3BPVo5YDEu9vsKLEQzRrZfXuewVX1TdUAoXy1c
 cbILit59oAnnzoWSxkzUDhVs5Hv67K/jjhSXZgmLZNU6kaL/USdvoZtvGj72vP1druSnggiPU
 E549ZyUdlmCh01Rs21sYpfnqQBOCGSxRlOD84jCn+Y7BfJkDhTbvW2fwy2QvqCO0sSF5S47Pl
 XUTHYKZHbp3s8gtqJAeqyMbx/ZZJ1ZXBDN6HbSUhTunCYf2vIHn54sP+mJGe4nNT+JeyVT7OB
 hRQmIgr15JCb9YDEr264oXN6yQlLsJmGHthjmNeLHApFy/JnCor07pjF0mIH/FpnlYUmuLuhn
 UyOXeDkDZAH5hfrr/o4m7jk5BmbN3YiHNKeu94GPJTKkFkYI46gNyFOtRa/LvLkb/gvxsJuzK
 CjaKOEOGtbY15fcEPtViN1i7OpaTK+ThrBca2lejutfApaIHGJblHxzsoEH3OUvBov6Ty1FCZ
 hH0S82T93scWErwcFTvD6zxKEr+wu3McGAFf5aO5oXOUQ8uAxxPY/AePyo2AGgOvbs1zdW3Zf
 1zoV7usukr/TByh7TZvuZ4BayAeqFN79YomppIXXV+qRw8qeYXGTorhayPkkyDjuLBzIhU+XT
 mqpiOUlcqy//r27Kkp+U7v5O1RUQsNHuvsJkci2Mjf53cxXFKhkTU/rsodScT2yVP2mgAqhtT
 Uss25G0c1UXjosF6623gHRD8H7TGVDIJ+pPzhi6sfaa39jMhXuDpUyABY5YWGJjajmMzr8KZN
 SLx+QmeRP7CsNwSV/UU420AOTLEtbXPrjnhl5XqwG478fqMGNk7zHJk/LJhOhtitcx/4+uC6G
 ihwfLPhbT6IIY4+x/E1g=

Am 19.08.26 um 22:11 schrieb Rafael J. Wysocki:

> Hi All,
>
> The upstream ACPICA project is undergoing some changes that require
> documentation updates and similar, and hence this series.
>
> Some of that is due to the departure of the long-time upstream ACPICA
> developer and maintainer Bob Moore and his immediate successor from
> Intel, but there is more.
>
> The project's license has changed (hopefully for the better) and it is
> now going to be the BSD-2-Clause-Patent license or the GPL-2.0-only
> license (as per the SPDX identifier).
>
> Also, the project will now require Sign-off-by tags from all
> contributors which should make it easier to track the provenance of
> code changes.
>
> Moreover, the ACPICA repository on GitHub has been relocated, so
> basically it has a new URL, even though the old one should just take
> you to the new location (at least most of the time), but it is still
> the same repository with all pull requests, issues etc.  Nevertheless,
> I apologize everyone who may be affected by this change for the
> inconvenience.
>
> This series makes updates related to those changes.
>
> The first patch adds a CREDITS entry for Bob Moore, which is well-deserved
> in my view.
>
> The second patch updates the ACPICA entry in MAINTAINERS in accordance with
> the current state of the upstream ACPICA project.
>
> The last patch updates the upstream ACPICA repository URL in the only document
> other than MAINTAINERS in which it is present.
>
> Thanks!

For the whole series:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

