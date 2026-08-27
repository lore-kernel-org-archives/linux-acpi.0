Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BB63D171C;
	Thu, 27 Aug 2026 22:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787869849; cv=none; b=PdE+z9haB/LLk1oHY6H6BOVSC7/aYiAifDnC9P4cJnbda7mJOeOVlEyTzmsysDQOgg3Fy1N5r/TOtnDtCerh9TMxHxCQLn3yWphNml+4qgOgSru4DWP3KCRdfioT21qEceEu0Ph6wetsGo8ePKtwXfep2d/qJxSiO5ffvIyCWGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787869849; c=relaxed/simple;
	bh=bunhE7x0Q9hslMK04fYFDKNe7j4QuiW7WYE7Z71KMwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rz7ONEZhZCQORPfci35EA7Z7jqRBysjGiclDfYviGDvnq55TulPXXM1fbRjYN+UF+h0tQgwvMaUJ+Lr0VWdfjY/7IwsaQCtUnRHiIKq1umhyW+eM5pC2MNKbs3fo1RlIXw+yhr4jzc5gNKBLaoBSYHfXek2kHrR9rwebsx9h/Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=PQX9GuN6; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="PQX9GuN6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1787869841; x=1788474641; i=w_armin@gmx.de;
	bh=g9E+g6hY8JCynLD4dQNws4IsMvoEVEOa3neYwmaqEPM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PQX9GuN6FYocLKsJ3fmzj0MwHW6yBWq6vosD1ywjm6oDdMYiLryMIsF8SpGIRV+6
	 sp1qP9Cn+HU1gi+nwkRszKkJsIl2yqx5sTAWf0NJMnuN/slJ8BPYCc9EgCrkD9DPV
	 L323g2mtgOsBMzH+WIMQ2yqsPSO2cilxbL/xf6yGpvP94Oj7tkRNhhgzEMnYHGqb0
	 S6eTViHr0Mp4n5TNw4+1nZGE8+o3Ib4b9PbiPhrra00182NPtBiWHxYg0IxZgPZ+a
	 jTuAoXt40lyhYECp9ASY6I7RjvA+iafZ5gHLqaOmE31HdTWXz1USN/DJ5iaedV6Dp
	 ziva/sR210iPumCyDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUGiJ-1xQyY62me3-00NrwE; Fri, 28
 Aug 2026 00:30:41 +0200
Message-ID: <ca37dbf2-0949-401b-a1bc-c714a1c451e0@gmx.de>
Date: Fri, 28 Aug 2026 00:30:40 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Add UCSI I2C transport driver for ITE885x USB-C
 controllers
To: Edward Blair <edward.blair@gmail.com>, linux-acpi@vger.kernel.org,
 linux-usb@vger.kernel.org
Cc: rafael@kernel.org, lenb@kernel.org, heikki.krogerus@linux.intel.com,
 mika.westerberg@linux.intel.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org
References: <20260825201426.47030-1-edward.blair@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20260825201426.47030-1-edward.blair@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:DH+r3S+SCnneffPluEVzaAfZW7Jz1Fkz8oUYjUyTqFqM7glJN94
 BUbhTQBd0LFMNwYyhL/Zqp25aUHGuSmFSbggxS6PZWY+q1CUsGGDsgQzKReYcxjeq2ycFWA
 GHxgxotcStbs1EVwllHUXrAIfCmKZNXMHAYG9Dm7pY33U4deHzgnbm9Xv16i2zHtm3sGMCF
 gsSyKmXa0cO+uw13QUBEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZFd2qu+MXUs=;t5Ero+Tmp2uZFxN+GmKMkRqoP3T
 Fql5egDl+cpxaMZWNOEWAh6+cZqLPpJ+hsLOaENTTZsra9Saeq4ynpEb5NAD0RkeeBTM8ViIC
 PbOR9TPnoUVcZtze0rC2BbQDQRTv5qq+0Z2AE1poMvJq1Oxo35wP0cus6X6cSBYuEcVwV/3J5
 jQ7yIL8D0XzyoPGsX8QOIbzSXH2fHn1SkqAFHy5qvKQPlNlXwcr9/KbPDhk9P68uwIX2dQlOJ
 9xaO304i+rbYYL4Z/7ADRVc1njjOQID2j4PoTf3R2HAVTwp8VHB4EsCI2DicE2yCXZcYVPnZ+
 4JDpUYP2dSNWZEJd7FbTr8SMnL104yF5qpofk3YuOUBstTcxL9tuh0sRc3vLWhyK3kWbcJH+u
 Fnce7IpWLsPFU6HReKns4THCzKwWBnCWsSEQuIY8Eg2cebrE2gFS2wjKTS4yzcqBgd3KjZ9Qv
 paYtZG4K+hTNqNYlgV6/ucl4m1Wj3aSMEQYvshhKgLHdd1gCIyF82pmexrTFQOss57Ja5g1BQ
 tI71gtkqHWrrwaLbyLuLYRLj47Z0VD6pcGPrGsmYtvFGgmOSOYHCUb1WCPNslz80IocwAD34q
 G9Ux3IrN2FoWooITo4AUbF8kcQXoMsMQtdr4bWtmeHNUISreDq5k3a4IOy11LKqOLcZOqBQkn
 yXHM/O2W8o5Om6F41rcnF1bAxLw00HBeFIqT4fCKBLlQ+PuxLD1TwH7p7cuX+LBdfOYnD8lXs
 xqH8JJnlqWERMp6O2NAVrL1MwTaIlMtwitODjpCdMxVeX/ydRx2wBQuputAuqt69EuHmOj/2S
 Dhn6pGvnmqfKWg9+nyFzGVXtYp3T9XvvNnixFkkpUdoCw9aaA7fsHSSvJ7i37TvoQpnTCw78j
 HrMLg+2KMS0C2C3vFrwsjDyt2C3lqGW38kNwa68cLMRdfpbaMeHug0/e8ppa3EG6rOLDU8xbB
 C/1jHPIoMzBkgi3aOzk3at7T+iuXkkDzhVG9ZkU9Tt7KjTVia9zFyjmOTHX3Jh68e1G9+9uZF
 V3w8g8s0W0KoS7CVcfz0i9DGNp7Kz2WiZJ0IGAeH2T973weaGPbGwvaTggW2l60/Ha23laJZh
 rqtIU2ZTqABAuZ7HFT1VRVfEy+858gRWgAT8quTKG6LROQthbmtSx+Z+03A/6eb62V+lGE4dN
 GIJXTpIn8fghUUGKg+ROYv7LbmJ5PzC420CH5BT16uy9CobKIpSpJdYnJdkqk8w4rjnVDBOa1
 4aub/8VuCBiUUi5sh412I7oryyT7FIXkmG4fyfsLw7dIOcDJFpu3tFjpk6CDxgVsxQ0Axgssc
 IpBVNoqV8KCkXpsEROSE0i1cnTIAFOb+8Qp7Nroh82kFhgD7+dy0d+9yOrDkJKpnXKSqaz/Im
 NUSw4aA4MB6UT+2h4vn3DrqiWoaNEYFo/PBuIHp91ulgMr+ZiVlbJ/laTSS+bqyfPopi9C7Bc
 l8bbQIbkJlqHYJEoLv/PgCzwXJJiIwbuITdP5SJwdUGsxU91T7zCMewiDhK5ui63TwADqrY1N
 do5ST5mNnfZzIuie10CRcTYoVsHyfBZfnxvZVH1XW7sdGJi3sndFz6WX741ZrWdTW6cnAFLGC
 6Iz4u90nwbIsm+7kFsRiqvqpuIe+N0XIOdZVm0EJI9Q2uceG0imWRGWcAhbczr1y23irdndYP
 NIyneMyQll3p1lJ7zkM7NQtKEruFzbK+IWJA81ec3WeTxqWNvtKKwUpiEax20pB6rvwRcgdBY
 Pp/B2x6kay2QtuE7TNRHwIro6YDbn//fgSoIgonXgSDbouRlx5p2J8EqcqgjK8/+hhfpbnrX1
 4fh4pXpEcogla2n5UtcBa3/kCIhqXO+tb594wLysbtHrUcFSSjjc77SUv/iQu9E8aRD9B/Ie3
 g3U/px0InwYK5wF2OwO4KnlT5tKwCdZR9X6zYXWvwCgbYEWxe9iKXuoTSSUeR1no2cu7w/SHE
 XQLjvp9ehbBlUteovjOGBQbXjqqQD7R53nUf3jkfZI4DjEKdryAyRrNCGkAjJtK8DOkVOSfeP
 /akhjB7sk9EqkGnAZj7G2o080AFbQkKzEQL54SiDj2Dey8E66cBNl0SSpAf3VaQqZ/ue9kBlF
 1nXG6lPj4FNo146WjUMGuncE6bpnVzJEkFL1xKf7EGyrD/CZrDIcBoLuDOTMNtGmwE5LiaLvH
 3VpAmUp66aAo+WvbY194R+3cW8rrGoJbdi238/SXXRvYcs248lAi7CZuVvYGI4dVTMq5qlONr
 /Ua88SOkZLEpCfrq48tfjHU9J8RVrU1Iswgds0Bf+d+6/mYX4vmEjdWIgDp4aQMTjTFDmO955
 QfI1zmmMe2FgqXiMj3ntmXijjgoQ2Eof2A5sktk8XMcD8DxvNyQMYSO9MV3cHHYaeUM1p1NES
 ehiejUcdm3JdYmKjPGqUP1/HyGjm/seKliOvrMmJ8jGk+CmbSj1yBzmXZDRSjzK8/yTqdtN8r
 QYMO7QLR/epPovAiBayoUSy0l/bJh0cy07WTrgYTnCes3PafT+QUPvU3PhLBydm8j3/XeAgSr
 w4GIARXK5M5F+8q++2OvATZ007SFTY5c/tRh7yr/dIIvQyCvVumQQbzwPraFrroXwboXTaT/2
 ylmUBhkABioZnIaC10js8ZJnwmU8fQ3Gp4xZDoL4TkxP6OEn8dEJnJLTfWoOP+EMwfmX4N4LU
 s4HGJTCzLoLkPBebqwF01hDp+ZIBZEqwjlSMc9p/qx2FwjmOInCohb3yVe0cNfLgp177ScMFH
 A7Y0D/MqDThhn7HJwYfZuGffBP6egWE4IP+2oRO1+dg16xiTsO9zr8f1p+bJk5t6sHgizKRmG
 +yAA2MFDFow9mxSfpv6pdK7I3PSF/YMiSBcoMyWeENJtIJVcU3I9Jml9gdfTjiuN9zZ1KgVEp
 JIsEmYXWRqSf66H2JMqBP84wayMiEsF+hnkkq71RVGXLzBgjTH90hFX62wEa94Ht9ZPtd1Xcu
 eO98xf7WVXNLr8IRzZjX2PY2Ihrr46jsLSk01YguFinBYgquZ1UIoOGwNCta/XD+jI2rtFivd
 pGAxH4wSShVfp6QtC33dO3T2OgTPTlRK5vQa5mEGCi+c7yw97MJZRnEtwX14zu3H+A9/BESlg
 4/EkTWBl4yRALL5keUeSdoPXhgxIm+QpDtvGgZUpCXhWkcmJnlXPvEfEmALOaVHj1hKinAsjZ
 3vFNmCvDcJEisgtDco/5PYqFU04H8GTNbuJQbd+94cPrlwTka4bsyffNECF1mnD6NmLZPUAhl
 h9jGPejUTooM4WtBa3L+phFlh7vKPPIGAsV5mzGk7Skcj3EO0UCRm40kbBqoc1H41jS4P7j4M
 kTlDJjguvo6wwPEhPQgvJ8hlYvPoL6lBbn8qmPo5XJYxObLGY+qjsCDqwbz6udSqqUSNHeq/M
 ZV5XNh7PDSKZeB3yrJYWzd6oxUivGF3nNFWvIB+u8DOlmdfUeoRYENmGa1/k+1rDshqjk/yo6
 a8smN4q/xArHhyCUlCTEfO2ohais/DVdOZSyI700ff5PAlWEZ/uQgSNjjjEO67vtCH+T06+mH
 UzBWYYuOTxu6csFK77U1Bgz1jpdobzFLB3TOlLtm17p3myJ/HblqSjaCycrrKDp6buVySUeaV
 Mx531Iog6gHV6eiC1vKdfT4Jxo3fgc8Hco2JOQBU8KmMdgRtMJ7/++u7XHZAHlQNJlnEGd71l
 DsFkemexqW4II+czTsVJLrT9ax9xdlgCmrm/asE0MCPGU+9fj3W58yiku3QT90iJuuysJmgYD
 yX5WnOEFIT6QNPmbAv2z3mlURj9hvuWVdNBfoYAYwVgXJcFss1HeAd9FUwJ4Ykxb1BMDX3vtf
 X/9Nj2MQFqzBPRdF/0SHLUKoFMgeNHlFfNiiCIiDOBoCe4egb1KUbSeQljak8vCgVCrtpNHVX
 JKO3wHxz1fuRbYEwbxhVN+lBL2XN/qK9u7wzbNdA+l/Boc0zURHi9Z01jazi/qxuWmVtPINvh
 f+r+Ta/lYuCsowX7wTBDQjyI3anyzRW+OrYwRr4sz8KygeKh3ACQne2/O9UJm+Y2L9XlTucJg
 ycRgROweLp4n2JwqOdL1DqaH1eIyzmcyxvEeucLq38qoTwHh4FvlkANqZsQGUa6Pi28GG3J8o
 AWDq2EeLHUxr1LjrijCVmioFaBzd9UlqCSEiwc2RIF2NU66r2wv01PgwnAkw090YNvBtqym++
 2k7N3WQ3i5Y+c3jZsSfkDT7uLTCHNrU93PMVUvzCVeumd7a6xaedOaEOxMgX1mDpoP3H9pWe5
 adBcBHZQ//NQMn7Nz+UJo+i3VcCaFlE2oQm+wfE/CYKGvU6eU791UNY1rLFQ+sON38AO3tl2y
 YgTWuusIJ2y/YE8NKc4huZhJJF1DtJZARfCwE+3+oA9k4jTOJW/g3C8HORTnInaQfiTPqgvGH
 fzaFmpxtd12Ws8h2NXwagtnnlQaCj6qmBeZcpHCttM0j90bYfzV2H4YaUv8dx+2mseFyMvrtq
 jmzmLX1pyFpiH10V5F8z3V62UW9YZtf2GEU3BVnHKe2LihiT1aRbi2GQcKYZ6gGGD0f2G0N/y
 JSMXPIEYpyih3vqrC6UcFbwzera0l4xaCM39WcrH2OEkmhtpbxyh6G3HMUPlLepV+e8Cmfh9P
 mrssmaaloNiCFlBGaB2g6qu5vLBcIsfCyt9JqEJRoa99HsmmpR4qRX5r8BUoEkM50zl7v2cVp
 FQ5/Pp19ey1mUw9wRnyKk7xKluJDbdzT8OxQcoI2bQ67XDpV90Pc9dgj5ok6XH3ZN/Vsl2q3e
 30hcsz7y7/XPyVxYKWZicT4ANTMdzLNkykaECrtoOBwvhaq6hJ7Et+v+hN7jG5eL/B1Zj0SNk
 d4v60SqJ9QYpJpIhXyix/MHHuTMYve8qJBQntiausWKA8c1+M2GyN+AtBNNw3jqKt0KyI0kLr
 fKx5vvfX0azzcUairSIrL9F5MdQT9qn6cJ/BWRo4rglTmaliu2bX9BIy3gqFM1hdYoW6LmkAv
 l4NT7xp8giWSL4z+IIKXZ2ZNZEugut0BMX4EA0J32abNR4SXxgOdOVwebwaLKd5L2fgjKNn5p
 GGUkzvoRj8EHI2NdjHuToGExgn7aGigTb1zFNSOg0kUayIyNl80q8Pa+ir2FHrM5wqCc7BDKl
 ncSdPhh3vjDEoCCYfCP/k72f1qQ9s+F8DUH6ku4wQhbmyuh10kVf8bFF8RANsv8a693u+XLKB
 GXZ0KGGVjE5Z1hb+zf1tMdNt2OYx1oQaArCKIof5Z4nyLg138DLWyZNPsVMoOiQymawVyqBKr
 /kUQsHZvnubrck9cXejlAMjeiPoUUGOMSl9INTtaCdWcwCuGZ++B4D1QNZQ/yYsCo4c0fa8S9
 yJ7UOlQ/PCJatYsS1Ywl5zqf+cxi1YlUutuL9pnY3CbRyKcWdl9ZfY+Kev533LLUUwc1vVqtI
 scbnCpX8JX90vnC+eLagKYVh9DBPCH0tjBdEyjsbnNS4GFtcITnXMqQhoA33OXvvNlKxbqYdL
 s/FlyvyXre4iTgsQptL75ugw5UWhnIW1sg9whlM/ozz2MHi798sORzo3TuXcbL8XLiswxtElj
 eqVTccDH4oWH9ciGZNu4BR/UmG4ifRnbjhmoxycNlo3IcBOc2oOOwSXOcyYMFrCN7vaAgvbLr
 C3JyfSYuSQGCnOhOJbX63rSa/ieQm4BeZcrPbvp5lUgvo+i0mfXmxdon1gA5c7q2kTXZ05yR0
 AGgNB1WCD2eDD0bMjq1e6B6fUlgEGfbcMKpCWEsqgHiVmMM7OvMMfPXHTc+DvCgPBN+3eKTk1
 LO+ntKO4EBIP+7G++zg0d0XGR/qwkgb69PQ3b83ZbUdyAnoLrJUJeICmZsMIf5lb7pgRNLD2+
 5vs0m9rQKJ0pvNl72sk/+4SFgXzjQZr8VzrfotXv+Np96YKD2vKMS0Sp9FjmpIaRqPZX5biGC
 rIYhwPhwAbNtC5RlFScTQ4Gs43sYkTYL11Di1Ie1+ld2dy+RY2yJRKDQxf/ezvLpQ3PNRntkE
 aQME4VzDag4cyPUZXMc+qOI6P11G2zrUGdtu/+pzFZi5OHj+0X5tx4uvSRtqs931/HjuLYZxn
 Huhu5jUL4QzcqgC4czAeZZKPLwwQl4YPNmSpdt1VtFIUlpgegkGXD8vFMPmlI0QNASF482a83
 M/1irkVA1lq686GfrPZ927njYKz0Rw4h4m3ITMyIQAYiRLaNClzRvA7CUY6vFMqyJp/e7wEjL
 JWsI6f/7/qPN2MJ0BONcbNwobD1bBkr4DJJWx0WtPmR6UPo8WmrleKu1gQkg1tEiK7/X57vap
 +UrFz/fDBoi45yQUsagxNWu8SMjgB+EIFfvFbWH1qtkOPSlpyZQvanyDwbRHDaSBx2scoXsYW
 soC+MsknjpHrHW15p4askOcyGppXX6nYXmzVug58/RNt0PHQDTpTLh9NTbgdcsteeiAK7PzeD
 +ZXvNgkOQqZMrtPoBoLPBD9fbmKIY3Qd1b6EA+dhmdO7Erv2XesmzrcjUaVsH/E51tc3XscUK
 t63vv/siAJUeUTVV4CPT6iF7weYxQlbb3sRxbj74nMypcrj/F6nniP3+aag3ewGktJ1KUWm4W
 aNAh7EIM09CCo3kddnn7vTAnZSxmdfIUrsgcxI5TOCFI2IUuQ3HjfWtU2Ec9LnIMF5ZmU0VG1
 6cQBaUswVQCgzTu0BURBtGjnaHZTLWIrTuGL/Tji4mmTuzb4mXQ3GCXqHSRRkhmAj14I8XM4x
 u822fDGs72U=

Am 25.08.26 um 22:14 schrieb Edward Blair:

> Some ASUS desktop boards describe the same ITE USB-C controller twice
> in ACPI: as an MSFT8000 Resource Hub Proxy and as an ITE885x device at
> the same I2C address. If the RhProxy node claims the address first, the
> ITE device cannot be registered. Only the ITE node provides the
> interrupt required by this transport.
>
> Patch 1 marks the RhProxy node absent only when its I2C resource exactly
> matches a supported ITE node which also has an interrupt.

AFAIK the MSFT8000 device is used to grant userspace applications under Windows
access to I2C, SPI, UART and GPIO resources. Since we already provide those functions
natively i suggest that we generally ignore MSFT8000 devices when checking for resource
conflicts.

Thanks,
Armin Wolf

> Patch 2 adds the ITE885x UCSI transport. These controllers use
> ITE-specific offsets for CCI, MESSAGE_IN, CONTROL and interrupt
> handling. They do not expose a VERSION register or accept PPM_RESET
> over I2C.
>
> The register layout and reset behaviour were checked against the ITE
> Windows driver supplied for this board.
>
> Tested on an ASUS ROG Strix Z790-E Gaming WiFi with ITE8853:
>
> - Built and booted on x86_64.
> - ucsi_ite bound to ITE8853:00 without the previous -EBUSY failure.
> - /sys/class/typec/port0 was registered.
> - USB-C attachment detection worked.
> - No UCSI, ITE or Type-C initialization errors were logged.
>
> Suspend/resume and the ITE8800 through ITE8805 IDs have not been tested.
>
> Changes since v1:
>
> - Move the duplicate-device quirk from the I2C core to the ACPI x86
>    status-override code, as suggested by Mika and Heikki.
> - Correctly identify MSFT8000 as a Resource Hub Proxy.
> - Restrict the quirk to exact matching I2C resources.
> - Use devm_request_threaded_irq(), as suggested by Heikki.
> - Rebase onto Linux 7.2 and update for the current UCSI API.
> - Read and cache complete UCSI events before acknowledging them.
> - Match the vendor transport's MESSAGE_IN and PPM_RESET behaviour.
>
> Link: https://lore.kernel.org/all/20260314013157.7181-1-edward.blair@gmail.com/
>
> Edward Blair (2):
>    ACPI: x86: hide duplicate RhProxy node for ITE UCSI controllers
>    usb: typec: ucsi: add ITE885x I2C transport driver
>
>   drivers/acpi/x86/utils.c          | 151 ++++++++++++
>   drivers/usb/typec/ucsi/Kconfig    |  11 +
>   drivers/usb/typec/ucsi/Makefile   |   1 +
>   drivers/usb/typec/ucsi/ucsi_ite.c | 395 ++++++++++++++++++++++++++++++
>   4 files changed, 558 insertions(+)
>   create mode 100644 drivers/usb/typec/ucsi/ucsi_ite.c
>
>
> base-commit: 66498c75b4f8017f62d720d9b59675bdf3abce91
