Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795178834;
	b=IEU/X+XZwYlZY5ENcCAdqbDkS7VFZA1kLfiZ/r8vfWwGPX59srPLAcwsUUikH4HJK8fl
	 29Rl+6EPSb/QZ2Bq/UAqksCUUZ8+iVLyRb62SmrG5s4YdSjYrHbCzliBCWhgz5LQ+8fUV
	 7d4wf532X2DyOQDo59TE3EHiNeee0QoWFJ4ptee9s07sUm70S6i5tlgBuf0iLxwMcf/YB
	 KFHmvffhdR4zej9hhssX4AkvqDUSIbASVKHHnwTBUsKxlik1GigRB9/YqFQaSeKLQe6jV
	 wT1MR/uBCSJiF7JqNPRYe+YPGBF5x1biAbwicaGhvTvtfy+Ck/FuG3rzI7R5IPHnSAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795178834;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=py8dPHZrFwq8TuV945X6CNLxL3dFzwBxVrNpTYS0mGw=;
	b=sU8Sz/n62UQHZnj7n0xMhJeXv8McFA5Xwlo1oHT3M2yPegq4mRc8O8s/Tg5fyPQ2HGTh
	 La3CCFraaWHt63LJtd/lH4WXTzXxRYzTNvPu+8niRXJ9T8qdc/f+YklypcyCJRwi7h+cp
	 tQRRRn0ZuSk98xH6nR4uLRgseZd3FfWMD3J824GGioZqD4V98jiB0xSQf+eSRMEE9QL6P
	 7LhTx8nlk3qvDnmqumZ3RyInYbjWhTYeCnoG3VA1guQt2XbSwBWjD34+cs3TUPWDr0alu
	 OIxMMnRmmb2Iz25jhajUgmODQCXZ3oL5b0OB6ygeDDOcEK8P2VUdEuwuXuX6VPmLqvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mive7c++;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hTaPAazi;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A8D60A263D
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 12:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45A8D60A263D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mive7c++;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hTaPAazi
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAjtBe3731152
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 12:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	py8dPHZrFwq8TuV945X6CNLxL3dFzwBxVrNpTYS0mGw=; b=mive7c++G7f0aeIi
	tU5sPnck0E6Dn0U0OiTsRiS0pijJUrn/kt1DYm2ucaK4Td9V52HxTozQdgyD+eRe
	KrOaoBuFOocyl4fw7G8PYK+4a8rh633EGPQjcfLAMMSX4zfSTNBZzf1OW4tda0LK
	56DQb1FByrUvQO9KQQaHI0YfXbeNIyAv9tR3HClJlVU6wvTGlG57x2kT9phtQPZb
	Zx1Mr+HBK3VDye1BiuxHjovr5pMiM1S16VPt/lPRxB6+PZHUW+rMtkiu2M3BOhX/
	gzIdnQQ6TefS6g1GNnaqvxp06SR8hz9vDLEZJTq1OQhQ61yUCFP2XUEenZlv0y81
	l9kLOA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2mm4gfum-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 12:47:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f37c94ceeso367722885a.1
        for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 04:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795178833; x=1795783633; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=py8dPHZrFwq8TuV945X6CNLxL3dFzwBxVrNpTYS0mGw=;
        b=hTaPAaziTawMx/3bwS/ZQj9VcYvl1rQ/K5iHlrH7EXkVTtM7cLUtryZJtRahOkOsls
         3+ePkA9/fCO4WZnV19dkTQpdNWLE5yq8xkSkv1LqCdbdvBMMjqkVCl/FeFJrSFlDIS71
         X60Z7VG39ygrQZZ47ryPjJJBuqYUD/JiVFgRYi7U/NxyHcKgD1JsT71N/6lh4nj39/OC
         suGX3RJf8L7DibdouA8D0YYc510Tj7dBchLSPp5Gp/O+wlx9LM6fzNBNNAhL0nre+g1B
         1f2GLPUQNJpVIfc7K9iKgK4MWpV5mvHyzcItAQPPc8z14EwJ7mm0TdZeRMjMPZpRj3DM
         WwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795178833; x=1795783633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=py8dPHZrFwq8TuV945X6CNLxL3dFzwBxVrNpTYS0mGw=;
        b=B+iE+8Pz3Hl75s33BEUw/ZSTwRaXI29ylnN/RQczT4c7p1aDLXDdvOa6PvRWqOjsKB
         91wBQS0sLJPF5U8TY2gsSb4fut0UJcQKwOzq8JjPOHh313ClF9hqifDtjb2js9gQvNiD
         NZJi0x/UKKIIj0KmVcNUYWRhfd9QeCfkGzlQq6WYu6BIRSnK7E16MEI/TRBEl9lVhGPD
         dT6uWtOyaf20AsYLkrzjX61EBJNlbg2yzNMetGElxJIr7axG+XEbHSZWfrfUv+vulco+
         niD7ULz2SwmsVm4u29eDTeQmz29TdYvuFlY+HguCd6GX4m12ov1uDKYdX/8h6xKL5Gpx
         K6Uw==
X-Gm-Message-State: APuU4Z/BdHZJ+G9TWP7ESAtiTkH8wa7HldyNAlaLlVRV0NM+4eQjWcY5
	CGYbrpiR2Xx3IKligx4WZhj17LyanwegonEkY/L9HYMTMyhAr2TllMTAf3f421RDufrOqqfl6ME
	BIvMfMacNZJsuOTqm3NP7uhxdOvxtTl73V79LKbJ/ptXNJdqbYloABIJS6w8X03M2
X-Gm-Gg: AYBFou1w9ZwZtRcY8jyWMS3BdhxYfAEJDxMyoNEuekZrdH94CL5wFysekk6G8hWP997
	48QDryW8Lg/cdTL0GUjfEuYKG8/LIk17NL7fnidR70SKzes7lltANMzIrUzMVICC44hXbp2QuIZ
	ZuQF5JsAzF7Ro6GtR3LIgRNyNJ4rKWof98CsnwuX0P9F/ulu3xgmIwr4xgMuZFYiC+X60WX/XDq
	HN4IG96uIw+/9Ftpgg04gJsm7PBbPpDfJCjoUJAVzE0WkLeXIqWjxevkMyb3j+pFFmTCrI7Zl++
	hqjR1v7/GKQ0gFcc3YBHnReYJmg5k685Sp4g3uYJrp/hVfR+2xOfPfC27yI9V/c46GQNN863fWa
	SG6x/6Kps29UD6qVyrqz+hRzYVjaeovbERh72Oe6aUn9pUjWPeFozfRP13uVCEESbXK5rK7JASh
	c=
X-Received: by 2002:a05:620a:1310:b0:949:6663:d1eb with SMTP id af79cd13be357-949b35c8cc9mr701837285a.21.1795178832595;
        Fri, 20 Nov 2026 04:47:12 -0800 (PST)
X-Received: by 2002:a05:620a:1310:b0:949:6663:d1eb with SMTP id af79cd13be357-949b35c8cc9mr701835085a.21.1795178832194;
        Fri, 20 Nov 2026 04:47:12 -0800 (PST)
Received: from brgl-qcom.local ([195.50.164.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884ab091sm119248995e9.11.2026.11.20.04.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 04:47:11 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 13:46:45 +0100
Subject: [PATCH v3 08/10] of: property: implement the count_references()
 fwnode operation
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
Message-Id: <20261120-fwnode-for-each-prop-v3-8-808e304dc73e@oss.qualcomm.com>
References: <20261120-fwnode-for-each-prop-v3-0-808e304dc73e@oss.qualcomm.com>
In-Reply-To: <20261120-fwnode-for-each-prop-v3-0-808e304dc73e@oss.qualcomm.com>
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
        Linus Walleij <linusw@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1493;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=1JYcW0VA6RP94DZpVTOyfu+AL1354zezooQUAMBcxYc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBrAEE48xRvddI/0N7DCqZkWBsifUkkdYI+c5zBJ
 vU46Rr2pqCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCawBBOAAKCRAFnS7L/zaE
 w6eeD/9FM2LleDI1LmF4XiZNQpXqyZxO5p6eXgpPVBhfUheIYi62FaI39M4l+qez4yLaX1zeW76
 dW5RMQie6Acezli2k0Yi/wTU4YfuHMlF6+veM8HQ3hzUZ4g7B6G8t24Ht4ev2QXihHfsRWFwJNb
 R3pQgTB5yJvxikhi25Lx1qC+CfEEPiVtYnCpqUOD7lGUO4Owx76xEcPSApmYg5g72g2jMElnBfV
 z7Z4pXKK2TEQ0JBglqCht8mZidYacc5Nrj0dmq2FwhE/2wGsvo+rMtVYLyKSOXTUB6s0AskLgnC
 wHMM3CLaz6AFr2BNJsfW0wlCWMJz4xYSPDcCctad+ketRddAWj2fh52mvwg2Zur0AmLjcDdy4mH
 s9aNWlzMW9/dPV9Gom/S15MII9bJLhnnxbyLN0k7pWLKKlvcftVZm3Nqm3A/NBlvwKY+LIRUSDz
 KU6TK5tSYq9qHpwJ1SQIu18hQizzuQFho7vVnrMZ0tVHpzMGil9lyVcJ+swqhrVaQ1L0YVZUKzK
 Cm0Ckr8DsXxsFY+emjQNA0TgPfS/pTj8KrlDc4lgYo/C2/u6o6HBofhaGJmu2VOjUo9X2Hk2nZe
 iSPEWlDeeasUNsF9rFmP5VJp+YOsdh/STmk/ZV2cU88FA/2rBSZYsbX257OXQ9PueqaAAhhbX1E
 AJc3sMoEMzH8r8A==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: EK6_gxa9D-EUrFwmEnBPwVXojAEb0Kl4
X-Authority-Analysis: v=2.4 cv=RZYFmFtv c=1 sm=1 tr=0 ts=6b004151 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9arfEEHKbLAzJOUiRygA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1MCBTYWx0ZWRfXynMmReQSyTqI
 reHCpbg/L82SgkWz5gONPuaKb8ncwWJR+k7f2OsC/rBGgSatPZYBZtUiAJ+jaa+/HZ0aQqsTBq4
 S1v3GwWo3roLmNLvDqpZac+QYWyU7KM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1MCBTYWx0ZWRfXwN96en31NzbU
 rN3QWxsrZY/2/a7jqIN+CQ9/H4zxvQ3X2qZH40zJ18bkj4Wf3btKBhLRCo+zAylQWKvlLxqpZVz
 IB5y7ZwGRcB3KxB6dmJUwirlZKSxUyt2H4HZ2dVXMZZPZScEav4aMfZpnCcSD7M2hh2+yGR/4Lc
 lerX8fvVpMHNiaEJuSAuRAGfKEbbLgLzaDDW2RrRgsnybKsSELxv6++9mhHlJKNW1T+Q0HTme7V
 cap1TbncfKquqhU3ikDHoRpS7FAZfaIP/wttGbIptmncB77MAhe1CrD+NpjxEoFtR0lVgD4oGma
 yklnlE+v/Wl9MQnJzfT+EeVzfPBuEbgQat910SBIQjjgMpCc9VLUOUJzIYq1paBvNMRYPNOWTLZ
 xlTw20Fz4DuL5Hm0TPdahIEvQ6cJeW0TJlFkvS+PnBiz60mUutRNWAOhiOAljVACIwCmLyBOdhX
 Q4ooREjHjjBEmNBUlhw==
X-Proofpoint-GUID: EK6_gxa9D-EUrFwmEnBPwVXojAEb0Kl4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200050

Implement the property_count_references() fwnode operation for OF nodes
by wrapping the existing of_count_phandle_with_args().

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/of/property.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index f914f0475e0be865afc9753fda5aa40a08a10e25..4b18cfdba802048364dced99af574a415815f790 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1233,6 +1233,12 @@ of_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
 	return 0;
 }
 
+static int of_fwnode_count_references(const struct fwnode_handle *fwnode,
+				      const char *prop, const char *nargs_prop)
+{
+	return of_count_phandle_with_args(to_of_node(fwnode), prop, nargs_prop);
+}
+
 static struct fwnode_handle *
 of_fwnode_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
 				  struct fwnode_handle *prev)
@@ -1749,6 +1755,7 @@ const struct fwnode_operations of_fwnode_ops = {
 	.get_parent = of_fwnode_get_parent,
 	.get_next_child_node = of_fwnode_get_next_child_node,
 	.get_named_child_node = of_fwnode_get_named_child_node,
+	.count_references = of_fwnode_count_references,
 	.get_reference_args = of_fwnode_get_reference_args,
 	.graph_get_next_endpoint = of_fwnode_graph_get_next_endpoint,
 	.graph_get_remote_endpoint = of_fwnode_graph_get_remote_endpoint,

-- 
2.47.3

