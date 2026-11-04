Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801065;
	b=LDg/kBlUHB5q5asETa5z36WuZv+y98PGCQiWD6PgF0kIBGvQ9PjTXH5xQ4JuPrUOI8Fs
	 MkQpILWSVS6EdxpwFiZaIdSJNraHgXeJ4RvFuI5F8SqdIjBJduMIbqxXSH5OdYUmtH3Og
	 9kGnmmnNrLL11SeWbM60MXjHiBBBQyxGNJ4/4bhAVXZwP1re9erLLDvRvxdO2JANXzfcr
	 lN3DWAM5ApN3JXU/zAc3ulmbjvYSvMvudB8WJm28vcyf5JVCOcZ5a0MSypnm5Dh2zk2PG
	 bjWLbx0k6FS8er9Bx4AuKV17DgytZv/wH0pM76Zpd65Fy2YwQY6RG73tNlWw7exO27g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801065;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=pxZg8c2Cz//qVnbPlOJ1FgV+cIcIhYnMUtcgwkzh4NI=;
	b=XNWSrPWbHmLJb9Ce8rahxOosVns5bIsKhOzuZ+2/OmT7SZ7ZTpQUG1Ua4d775H2E2xce
	 gSNUIvLw6hb5TpIjvZGxcrIV3lfDn7Mia2Lo5mpgGMrQo3npOT6BraUX2Tl+HwdECoSlB
	 ysWk2s7T17pEpeCljWcZFa1fP6j6x9xBSm1DYRmnEm4xpQSlJ7+KDCOX21EqHbInG8UIy
	 EtME9qp07Ex3+kDZKsAL2bY5IxOt3F3wOwvsRNOPONjfvPv4+PoLSQ3/++12bWFc/tqwc
	 teAwxbqsT8B8JyE+/c6+yt+vnyLcNGQtfpyjXN55Xj/tRsU7bsh0W9vBygsJqJz8D6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZyMWzQsB;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Lw7Ijwjw;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16EA606A332
	for <linux-acpi@vger.kernel.org>; Wed,  4 Nov 2026 14:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E16EA606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZyMWzQsB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Lw7Ijwjw
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4Ba04Q2284207
	for <linux-acpi@vger.kernel.org>; Wed, 4 Nov 2026 14:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pxZg8c2Cz//qVnbPlOJ1FgV+cIcIhYnMUtcgwkzh4NI=; b=ZyMWzQsB8somTKQ4
	gMi3RoSQ0KBzQTZE959mdwa0DCr+eXsvWQEDJdWxLa7xLthPcip4E9US2RhNMUWO
	vPOamxpI7QvNV51/ZY8ZpCnK/10yZlknDsWdxAzy1J6UcIcgAivPuTHQK+lgPg5Q
	PhPIaSavgqP12V00C08tkIK3kBM7Td7NRc+pKl5bjpgs53iwESuA8GApOxK3Fo5f
	TH1Zqaglwa9JC2cChxqY4URyvZkKBs+gjb2u2M/2c/bNR5Gu5giyKwkGrAM3gRjt
	ZTWTtuVKqwXtUxboWAGuTMnYMAjgK7eApbNceCSHyq02GsYomazYmOBkFyUucd/H
	+4Az6Q==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr284s046-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 04 Nov 2026 14:04:23 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5ec62c05c25so1657818e0c.1
        for <linux-acpi@vger.kernel.org>; Wed, 04 Nov 2026 06:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793801063; x=1794405863; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pxZg8c2Cz//qVnbPlOJ1FgV+cIcIhYnMUtcgwkzh4NI=;
        b=Lw7IjwjwbyDdLL1zDhlipkDiIL4B1UIHTWQypEGAmDbK9yCIoLEjpiaOqAbE3+P45N
         GS9rbn0Z/RM0g0xwqWXSLXpSgEOeXE4yIRmHlsw+WHoVvebQaH/bvCNE2nUKizWRDuH/
         +A4SG/xIoHOjgOiuGFUqKcAPUTh8+iIXleMxBb+eKxO22KDrONLgWnh6/4FoSxuyFDEi
         oiaCiuZqb7dvoAEo/ydU7oH58XoMhAys/CtjdSrjKBfY7Q9XaslinORWC9XINlxKpfJm
         TDzm4LYbkeP7qzkZNJjkGrPiJqgZTSnV23XAvI0wc1GuPWui+MAxhHBco+0szR1hk6DA
         I6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793801063; x=1794405863;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pxZg8c2Cz//qVnbPlOJ1FgV+cIcIhYnMUtcgwkzh4NI=;
        b=brrnrG73aTGxyJLBgcdge0CbnCwXP3Dw3C88bEgLFS4HDr6V/AoaMQBlBRBtCXY1NV
         90BkFarEXt8uCt2m89etabCt2QeNtoYrx8UnQeiZVTLBkImggyoJtagT02Mxzblzc3nX
         MoDs9JS4Zn3I7y64iTO4od1TjPLVzPyMcCNb+D1VvFxHuxVjGfVqbirDAwzHrtqIhN0l
         xdA2f5kj0+gMjHt5NqB9RXfHw/IARi75MDIVypL0yt0QxAxfO0Qzbf7IGPQsAq7q3+6q
         QQd+IqgUWWqUZ6CFxA/qXpM9U2vWTqJ0uZ7VXhK5o0AeSBJhQrfjob4sNVQsXtSNbmTu
         qGUw==
X-Gm-Message-State: APuU4Z+T8CfFEqclk5YSyx+ziVMUMGgq7TQCu5w7etIBK31O8bzfoLvn
	k497kx2TmGaBKnc2nOYgvzI+CsgGc8rXauifv6cBoSh7ZNbzotl1KiMXmHlcHac7PYyPlvJlmj3
	fPra/f8LhK3IN/Fm9XuLlBSKYN/f+A85uxj6aKKSKtnSI7grGOmst6enKCejqzEQi
X-Gm-Gg: AYBFou2ffE/bUHJJv/DCjm2Lev6tH4VVPgcqAVJ/RDL35jG05gVzgtYQb6t2cuFm+bW
	xApK9KqS4DFb628OgxYmatbMRDFvOnDjeVzTha0/Jx1kjiP6nhq3D38RpXZlYW8n9Gv4ZoOWs6U
	nu/C0PVAWNKeIXPe8H6Jq0+Bsq/4O0gcGQtFAcs0s4NFmKzIZLMK36J4pyBxYZlyUwt9H938rjB
	yGdxJkTUmOMQjgpwLlxCq6VS7wabpopOOicrsacI1TJP+4fOpHxnGeLtvs47Q0EBZjYzPDF7a+b
	grbI8ke7GNJK18S7R247gRaN01RazeEA407uhqGEVhoMMaFK7dIoazOPzFsiQvqSVupHs7x3o49
	mnCs7U5vsiHS7MKUq22UG7NLKLvsCYfIhY3FGcSxLsRNI5y7GDFmsTJi9l5/u8kFmbtRrNcD7v0
	b0Hg==
X-Received: by 2002:a05:6122:c155:b0:5ea:ae80:c97c with SMTP id 71dfb90a1353d-5ec5879d16dmr4306376e0c.15.1793801062991;
        Wed, 04 Nov 2026 06:04:22 -0800 (PST)
X-Received: by 2002:a05:6122:c155:b0:5ea:ae80:c97c with SMTP id 71dfb90a1353d-5ec5879d16dmr4306326e0c.15.1793801062468;
        Wed, 04 Nov 2026 06:04:22 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d87b5sm3968358f8f.11.2026.11.04.06.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:04:17 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 04 Nov 2026 15:03:45 +0100
Subject: [PATCH 3/9] fwnode: define the property_get_names() operation
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-fwnode-for-each-prop-v1-3-6e28fe1c72c4@oss.qualcomm.com>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
In-Reply-To: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Linus Walleij <linusw@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1855;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=vlyXEW90tuaHwDARKd4JGB2+R0K81QD4UYSlZBasTXQ=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq6ztSRKXWWkliovY8qVo68abtoXtQZqXdDFLls
 EQ9sf+1SpqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaus7UgAKCRAFnS7L/zaE
 w1S6D/0b5eyCDtTat976om/WwrrkmeCrdTpgbsGvagClks0LTeShFP9+nuPD7PIJzrL4/pyP4M6
 osTD1xtFE9oFRr/JKicYaJUhGNjvhq86+P4Nk0irweouqKLqlsQoiqolxRUCRRKWKX/JOFw5UPN
 HwY2EWjrvKNLBv9U6+Nifpym/U8hKQweflNnRfIXMu5yaCEGnzB13cNCoSr5HL1f//BkvCEHlv2
 OPsSAXEeenUZz0HAqp1+xs49AiwTwDocOsc2pYSH5fYgrlshGj4oIr539GC3P6v8XvTk5ciwE21
 8rqNr1cD+xfY0XRI7qsGlSTq5nHwIkmkZMmzCZvCFemTxiQ7z+VZ7fi+sKJOjXXDcDae7+6ti9f
 BKhxyuCoZ9ZUZEjD+bi6CaZy0KjDzBI7MkJ6QkbfHnxjI6f7HBgQw8Az4RIb47ydJsP4RSSktaT
 ycW44vOZJCTTGF0I8DXuOsC8RkSLV5XQYK9ZwB3eg2w1ZK2577lrjRb28GuXgAwUP0K9smBW2/S
 05FciAVt+9P1WzFmvql+IeSba0EOXnj6DpiZDE0L7EjBVvDlAxtiJTyKlAfGM9HaGAZtOew/agm
 7GEz4McYIbAFzg58gtwRtxBmmwapSdtihU3Aq16E+xr+ZxaM48Qkdrw6gtBtwvCisnZthkFavFb
 VxhzvSv/E7NtLnQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=JdQpPkKV c=1 sm=1 tr=0 ts=6aeb3b67 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=jHVjgif8OWDE08c-SeEA:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: Ry4Jp0VVHsWroI7QJbKmw5EltHT5CLsm
X-Proofpoint-GUID: Ry4Jp0VVHsWroI7QJbKmw5EltHT5CLsm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1NSBTYWx0ZWRfX2MzfnnXwH1JG
 OcPG447vpincb8tpmfbeLQmF0946jsiBwMxLAzz6aJXxWCdCgRU2IAAU5VOCyomFxyMf0HezNl9
 pD/rGnhhczOoD3655HVEcjXpc9WWerWiYxJJ+8+uQxVisusSxK6ystlxz15feRweMhdsZ4wAc9u
 C/+ROl8QEEqO+NZhDRDd40vjtKnQqdm2GGIzWP7mdC7Iw78XiLpfC1SGsG6Q7kPNJk5F38n2P8g
 NIGwmS/PhqC+z004Q73IP7DQESgzEBvflv6N7O+mNwF5GPLDgBND9fLkQ7vxuJdHIE5Ln/pmpxQ
 l9XU9Qw9kVgYP+kR1J0PK5DVTa63E2yw0A381cKK/msaVbnAoQ38X5azslvgj9YMDTGJaWeaHyj
 6bg1G04CpmGBrVxDstsOA+xDuH/SsleFcE2z7Lol7dFJSaqncm/lHFsSov18SQe7N/FkymbmGwW
 pzoCGIsIldMXqcWLsmg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1NSBTYWx0ZWRfXwFhRtI7iYZJt
 RUHlqk8C9yOvZ8xZ3FU3EwKsgxgwdej0GwTBknLX4dS7oUQM4KKdXGkuUJmxr1MJTaWFhwFI/bV
 rugRR+HoNFOwzUytzuYj2Qcf6i8A6mw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040055

Define a new fwnode operation allowing to retrieve the list of all
properties of given firmware node in a dynamically allocated array of
strings.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 include/linux/fwnode.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index a9dcaf7e70765637a0c33af2ae0ac541e15752ad..2d7e0b9245d445d473c7317bd27058abe5750b40 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -125,6 +125,13 @@ struct fwnode_reference_args {
  *			     success, a negative error code otherwise.
  * @property_read_string_array: Read an array of string properties. Return zero
  *				on success, a negative error code otherwise.
+ * @property_get_names: Retrieve the list of all properties of this firmware
+ *			node. On success: returns the number of properties and
+ *			sets *props to an array of NULL-terminated strings that
+ *			must be freed by the user with kfree_strarray(). If
+ *			there are no properties, 0 is returned and the props
+ *			pointer is not changed. Returns negative error number on
+ *			failure.
  * @get_name: Return the name of an fwnode.
  * @get_name_prefix: Get a prefix for a node (for printing purposes).
  * @get_parent: Return the parent of an fwnode.
@@ -162,6 +169,8 @@ struct fwnode_operations {
 	(*property_read_string_array)(const struct fwnode_handle *fwnode_handle,
 				      const char *propname, const char **val,
 				      size_t nval);
+	int (*property_get_names)(const struct fwnode_handle *fwnode,
+				  char ***props);
 	const char *(*get_name)(const struct fwnode_handle *fwnode);
 	const char *(*get_name_prefix)(const struct fwnode_handle *fwnode);
 	struct fwnode_handle *(*get_parent)(const struct fwnode_handle *fwnode);

-- 
2.47.3

