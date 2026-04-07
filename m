Received: from aib29agb125.bom1.oracleemaildelivery.com (aib29agb125.bom1.oracleemaildelivery.com [192.29.172.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E48342177
	for <linux-acpi@vger.kernel.org>; Tue,  7 Apr 2026 04:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.172.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775537616; cv=none; b=slkZh/tIVh8XthnDAksmaoJ+HNiUk9NiFpEF9qRPmL++yJ2ygBp2fq/EnvxJlfYOf/fP08ZnjOWphRoAybIq+XWsKzu8fgRA3rg1ZSHVdwgFyWuyCHbMZO6J3Z5YXUyT6Xc6sKeI1Pbd/obJPeNruB5copDJr4erqilGfjL4mmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775537616; c=relaxed/simple;
	bh=DOGNxOuGnChhZQLwlrQLOpL2pK7O5LofYIVDLE+YYWc=;
	h=From:To:Subject:Date:Message-id:MIME-version:Content-type; b=ZYWXZWO+U5l91jJwoyzOfb+dZYtTKfXKq2fQp3ba92i0LqrnETmsesRlNROQZsIV+ms9AW9Ns4E0++drZJa9jOtItkYjOhj8WrWS0tMhUnX4QyDR3cMgMEBSN6+7TkeShuUvTnxWaI+T5++hkdMipLxzAMCNr/jrF3RK2ijMc88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linknsell.com; spf=pass smtp.mailfrom=bom1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=linknsell.com header.i=@linknsell.com header.b=CITR1maR; dkim=pass (2048-bit key) header.d=bom1.rp.oracleemaildelivery.com header.i=@bom1.rp.oracleemaildelivery.com header.b=asGefRho; arc=none smtp.client-ip=192.29.172.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linknsell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bom1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linknsell.com header.i=@linknsell.com header.b="CITR1maR";
	dkim=pass (2048-bit key) header.d=bom1.rp.oracleemaildelivery.com header.i=@bom1.rp.oracleemaildelivery.com header.b="asGefRho"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=smtp.linknsell.com.20250508;
 d=linknsell.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=DOGNxOuGnChhZQLwlrQLOpL2pK7O5LofYIVDLE+YYWc=;
 b=CITR1maRM7EUPfhdKN7kzGaO2kk6J0xLe4nBXv5KsbRJMnEEYCMfMhsf06o7kmo5A1z6scijJyHA
   p1gRQ3fDzxiNIrlVZ4FV+HSBZgPYgCTRUnakwFanbuO9nnDTkxD4WfLHIdQoX1dAB5UqRmMROJId
   kt0E7bdmE+MZKhEkrGuWJ+f29TqP7kJ3xAsKlLE3ciw/D+mtiUaPuQR0Zho2WtgV4T7v7YwORjv5
   ZaX7WxnevKp9sIjR434yfLEWUPfZxJnn0E9evrV1+I4YUkSBdadA5XcniB6T/SQhbr+vogHqkV2o
   uXKuP5tc4K2/2qCzBn7ywIFfizU/5NCTmUiWkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-bom-20200207;
 d=bom1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=DOGNxOuGnChhZQLwlrQLOpL2pK7O5LofYIVDLE+YYWc=;
 b=asGefRhoHf4LC4WYR4ZoYLPpyap/jrXUiG1mbZIlaSW7nXI0uGCNdjpwGA8XmP+5rX5hyZnwbNP8
   /N4E7OOaUhN47L4oCx2ebnK+hejyT3r13wDwI3GbxB0DqBCigexIPGuqZ3g+oI8cqurltuUSZKyc
   n/Izjf/oZ2tifMBN8BrXlET+aCwdWWHXKcbd7kcRZDlH9yT4B0MvPXB+1aAII7xMpZAonuSCoiJ9
   hDkPcW5/pE2qQBT2HlLvQWI3Hb+/04QBQJfXwznfyJU0Z4rHO5gsfGj7S6j5BJRYjfA3bAxCkQN/
   QV4H++yOkI6VlPSZ87grRUO+UHxgH0Wlofa9dA==
Received: by omta-ad1-fd2-402-ap-mumbai-1.omtaad1.vcndpbom.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20260212 64bit (built Feb 12
 2026))
 with ESMTPS id <0TD300JDTXL8S4F0@omta-ad1-fd2-402-ap-mumbai-1.omtaad1.vcndpbom.oraclevcn.com> for
 linux-acpi@vger.kernel.org; Tue, 07 Apr 2026 04:53:32 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Reply-to: jisunlee@gmilweb.com
From: Jisun Lee <NoReply@linknsell.com>
To: linux-acpi@vger.kernel.org
Subject: I need your help
Date: 7 Apr 2026 05:53:23 +0100
Message-id: <20260407051725.F120973797C64E04@linknsell.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain;	charset="utf-8"
Content-transfer-encoding: quoted-printable
Reporting-Meta:
 AAGi5cWnrTT4y34B1qvDUxR1Rsnzi/bNdivngbcgnQHx1PzWyIJmi0ji+3UCCCnp
 D4cA0CnNMIO1lBduhQOtIeENYZguLw5sC/FJ3n+I4Uu2QRyReftLlkolsbut1nJL
 PwIsIVbO9g7wM6iP6E8+30+UuPK7TThbeHd6CpLj95pvcCEHTzryN+KUyUjRjYQR
 Wm1VR+AaZESDpt0UCzcihepgDh3/9bYIqJnHWGplBmKwR914IHt7m0gJ4M+Cp8p2
 hfVx8kPq/ZWen/4XvqDp+UNXqhG1vHXnRzRor17QS2oKqj9N9VBu7WH4RAiMPlVS
 XxaFvTzMigYpSAZj1C28Y2hnwpaJxV2H1AfPr//PVtDbx9qufFc6rfWU63qG7cvY
 KwoTJeevyUrIAXmXZxTRYT0aE/syU6RWntybv3HrPLLHVwm1XY9ARupuJXxvoHCo
 ufpv0TfyuSkJS+lS50psMfjohkIWgAZx5h/1xGgzGbD+15K278fQOin4

Dear Beloved

My ex Husband Song Lee refuse to pay our divorce settlement
funds. =E2=80=8BI need your help to recover Assets from the bank for=20
healthcare and child support
=E2=80=8Bpurposes, diagnosed with (bladder cancer).

=E2=80=8BI need your advise and support

=E2=80=8BThank You
Jisun Lee
