Received: from aib29agb124.bom1.oracleemaildelivery.com (aib29agb124.bom1.oracleemaildelivery.com [192.29.172.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CBF306B37
	for <linux-acpi@vger.kernel.org>; Mon,  6 Apr 2026 08:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.172.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775462942; cv=none; b=pI5MlYB/jEM7BNI4nFc4XbYRg3XgcCqEgD75NAiImU4oPkW+CKZNpb8I/06bBLVlel7K5+8D0t4cDX1KNP0DhYN5us6CcPMxil3MOk5nVTHP3T2bD/p/pH3+OeNNDtFU7vr19PL7UvzR7GMSTrDwDmZ6MfLBt0SSkYvAc9Xpyko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775462942; c=relaxed/simple;
	bh=DOGNxOuGnChhZQLwlrQLOpL2pK7O5LofYIVDLE+YYWc=;
	h=From:To:Subject:Date:Message-id:MIME-version:Content-type; b=dO9Ukj/mO0VRhKYhhF1fz5jpQvuzWhXyooGZEZ38HSMIyKzeNwTyJuN+/efc8YjzNG67V1hbCm8yykrv21G1xPdOvWm2vNar5pAMuoTGzUEujIFtJGdb3mIpwF/N/JvKVzvCD76XY8LNIKJxT79crxxDBfwprsxg4hMDwtM+sto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linknsell.com; spf=pass smtp.mailfrom=bom1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=linknsell.com header.i=@linknsell.com header.b=EegMqUbs; dkim=pass (2048-bit key) header.d=bom1.rp.oracleemaildelivery.com header.i=@bom1.rp.oracleemaildelivery.com header.b=ryIfHIJo; arc=none smtp.client-ip=192.29.172.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linknsell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bom1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linknsell.com header.i=@linknsell.com header.b="EegMqUbs";
	dkim=pass (2048-bit key) header.d=bom1.rp.oracleemaildelivery.com header.i=@bom1.rp.oracleemaildelivery.com header.b="ryIfHIJo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=smtp.linknsell.com.20250508;
 d=linknsell.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=DOGNxOuGnChhZQLwlrQLOpL2pK7O5LofYIVDLE+YYWc=;
 b=EegMqUbsEIsIOnJtVI5SCygOUqjPi/NNzYUo12wBteREbkj7zyHfugNSlvYWSQNPHeKDHrCRCb/T
   gWuKK3zxrblLTyIOGvb/TI6tfkFbK1O7kpeftOHKsX4vguLy1INSY7rgoPnqhah1f5GJGtWTq8LB
   a4oWX+rwTGs/7tUUNOYDV1xlXQd2KeP8XUhyQymlEGtwx7s38G5/DsycwG7PRIijLh0Dabump4L0
   +Jbg0Ipg9RdjM0Ap5g5palDc1z+Cs309/17rYAOBaFT76OyPfkQCB3apNTfG7gViw71Bwnukqt0A
   z3/Bf9X+T6kRelorYgi7A7F5fS9mRgidSypwug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-bom-20200207;
 d=bom1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=DOGNxOuGnChhZQLwlrQLOpL2pK7O5LofYIVDLE+YYWc=;
 b=ryIfHIJoQjZp5K5/Hi2SbfHGVETPU8kDH1f6CVcEm1jOl6U0t8IAc08hH/yqoBKMxouiCZfIjr5o
   +IDjSw2yQz/bOgFIzsHQ1z5uD/edQdHsgKHJgpSiszYuYz3lw74xxGRH+bJTMeOs6mgfQNrINOFc
   1uIuaKdAamvQRujm19DqlVMBpES3/MJWzxktmu2F+CSN5DlgTy5aF2apwhT3SrpVqCWZOIswtpXA
   zeh0AjI7d8BRCe6FonirZpmkH4+Yib9pLCrZyPcIQxbDX3HWOj+Tl6hvT71EeVPf90TcWWiWWVYC
   Pk1TWHstQKRuqiovvu+7vShcWIuftwtdfVIz6w==
Received: by omta-ad1-fd2-401-ap-mumbai-1.omtaad1.vcndpbom.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20260212 64bit (built Feb 12
 2026))
 with ESMTPS id <0TD200OWCBYYSZB0@omta-ad1-fd2-401-ap-mumbai-1.omtaad1.vcndpbom.oraclevcn.com> for
 linux-acpi@vger.kernel.org; Mon, 06 Apr 2026 08:08:58 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Reply-to: jisunlee@gmilweb.com
From: Jisun Lee <NoReply@linknsell.com>
To: linux-acpi@vger.kernel.org
Subject: I need your help
Date: 6 Apr 2026 09:08:54 +0100
Message-id: <20260406075048.1CBCE27047FC8157@linknsell.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain;	charset="utf-8"
Content-transfer-encoding: quoted-printable
Reporting-Meta:
 AAHJhDAuOA8sV1lZe7u7+TxozXcYi7C83O5sjYYkIwEdyMAUNGsi6DfD9cZF+u1o
 JMJBhnCV7cgIRNeS7MzE/Kh41zHNFqKUrP7mXZjfT47Ogh4/Vhed3brjggpKte1j
 TtGDDdYMkb+VwEZ5TiruRra/66Qzmd/yaiJWgOLwQk+iZvNf8FkhoyDLwzle7RVS
 X5iZXJga08XDcwf911xCGYM5n8U/ug3VwFFl+TjOH0aig0DdhJTmSI3qer+8J/wZ
 WUJCkwmL1AS+hVjDZboGxuGpeqOaKjpGJaj0Vhykoc8T5DBKQ4WMT91ePHyFO+va
 PfUVVitoIHsson3JQtC/WPOJj3CKEw34eprJ4wx3dGDp/jTg46LETZT/ExPJkfdU
 kh51LbKZBnOjMuQNx7/iIbQ58WGvFIr8+v71kxkotyTmUHGxPJ4JwWI2N4mLbbta
 0DQb+31nlkjc79HX/slIDEo/tm/swiVx2Y1zcWmFXlV8T+RhQdkDr28/OA==

Dear Beloved

My ex Husband Song Lee refuse to pay our divorce settlement
funds. =E2=80=8BI need your help to recover Assets from the bank for=20
healthcare and child support
=E2=80=8Bpurposes, diagnosed with (bladder cancer).

=E2=80=8BI need your advise and support

=E2=80=8BThank You
Jisun Lee
