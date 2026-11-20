Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795178825;
	b=ceOwet5MNGgLq1yEqgtnpTpF5U4Ybh5adJFo8yYu5tPg9BRC2RIbnKfAJfHizC/GyYEs
	 90X8vOvWW8jVCMPvBOr/zCFzHM/n4C2SJqpVcCAnSu3NVb4JqqiTcbRkwW0pFPTRcNXlR
	 UJ3zdJb9jWMB2qpnEmbFkhu86hlAp7q6CG3Bqw4kEUc6pYZ9kuUS2Z948vzE0Wp1bwwCK
	 TXIyDf9hZBzXWyF7RBFp6hmArTwYMikdMlMMfas4B4z7AdSzFQzucgZ4/DdZ6cE97P5k4
	 S4nBMhVkbAoSHiewWN2gwC9z9LhznwLfVWHsmzgSVkYv5hcn6r0mzslvPIb3MMGJ8bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795178825;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=VW9PgIUqddV2ctIph8GklJCXOd/Fbs2bPwpKZj/erTw=;
	b=ce7F8+745JMmbAhqCGGxANq7y3CZkbSr6t447aie75Q9RTFikeoR7NiJ2jQiztNwlic/
	 Sj7jYm5xcQdFpP8rjzSieQkw4k1fG7gmu5vOWpdkus03DJ2kSMxJT2fpUdisFTNRTlblZ
	 xq3ftmd1TVy1CiGczA3jz+uPr+iFiXvJY0sDsnzxGVkQB3saUcuOtHXz1ns/bHS/YATUB
	 XT3SqXhAyCkxQEIUZjhXjJD/lj8mkAAMwQxRiL7lLxAztgk+wDyYL0nRjNkHxv+WA/dFx
	 8wfR4s3Q4AgURKVt2kvW32XsaxBo8vP3goRFUqqd3JeKhScqTePixO+ntAZR8UHlpZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ko+ched7;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IgcpA2Zs;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BBC60A2636
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 12:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7BBC60A2636
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ko+ched7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IgcpA2Zs
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAjuAD3731392
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 12:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VW9PgIUqddV2ctIph8GklJCXOd/Fbs2bPwpKZj/erTw=; b=ko+ched7bFDddz4F
	j8dhA+j429hqyz2yk5Ncmi5aAa3rgLQEWYbkwqZ2RN8VZovqVe/lh1VS4yaINoO4
	wQkSsHZOVJDkSGMiPEqNIZfepjZpra8nb5wETHry4dTe453aseWRXnQAuWxMOGA4
	4S8u27zNH1TTH0ZUt0OFWOWOnzE5RXqk5O1vEvUOdcNTAk6+s1nVhDFyn9j4Iwhh
	XvCUYN66Nm0Gm7nPM7q+uHW5hAmus9Zq8Wd2P7KAGxExFUjwNDUYan2klSNHEgY0
	xs8b0U3v0dkuh7JxhRSD/S9BgD8Wp8JOJ1oyUQOLTO3sz5EtAWYNCdD98T8YGE9U
	kJWByA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2mm4gftt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 12:47:03 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-94960131befso151271185a.0
        for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 04:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795178823; x=1795783623; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VW9PgIUqddV2ctIph8GklJCXOd/Fbs2bPwpKZj/erTw=;
        b=IgcpA2ZsZqpVSl7v6IyVW84NU2m59ch+2cnf597njxpkDny5cVH+v0ejy9ieyN1jrd
         Abm80g/1vvp0JmB0dojOKhnsaqMQpY8mTkSnaZ49B+NDC6EQp/gnHPxPvnQOcAl703Ys
         t4rDl0VsdNgZEJ5lAY+xFrcAHMLtMN0pdIqhVKECsP/+k07rSJ1jxrcOeYWWEo4lXsrb
         aj1Zlj+J2qZWPj8B6k3cFgbEWKJHgvLaf3LQIyPdw/XcFunfKL+LnxsLRTCVnWQj65au
         IA97aK9K0nV6bD8hVi4nmyKiWXqtCUdgu3/0l5EP3uEJoIoyO/e9CQ3Pij1OZSJnvYBu
         R/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795178823; x=1795783623;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VW9PgIUqddV2ctIph8GklJCXOd/Fbs2bPwpKZj/erTw=;
        b=B97Z/KUATL1ytEbXO8GxzmHBpO6vD5hx+tSwqCbgpE1OsO8wDmgC2Ta1EP+ZXc9mef
         Muo1k/g8LKph/RRf58UcN9zTheplALl7Yfut1WFzxGOkiSci8VROwQAbzbYaUbxRlizQ
         ZG0Ts4TSYJMlxp5YDOe6qO7uxlZ2xdJ/jGilimGQkjwrRmaz9G2fVrxDE5twyFAK+n6M
         OrairHm3FsOmJ5p1WFYDFzEYhuLfKe/+9e1bliGkNmjhZD5lo1ROlisHQWKBIWNpLRRQ
         Hl1fI2I2/seZ4wurUMkLggvfiCDbPFQqe4eyksoioyFzTCtS2OAVX4q6cT2cAygtmAcW
         0vQA==
X-Gm-Message-State: APuU4Z99F/sQ1FiJFTsts8123rDrUBx8ZxXP1r1froQVq7glr405W3Lz
	rp1xQ81EXAtcGU2cLhYLzdzuGM5AvHVB+4YGhlcrHiWfEXpfw+R8anTIqksUZnpBVePeVzGS6Tz
	G83DWFQwjMWfH5m+fHQ/WjN0HeIQhwaK7DDZ4Ljj+h082OLbn+HVVFK2polfYDrS+
X-Gm-Gg: AYBFou0eT6i7fLj3+4dxu5yXCOt2qQv3Rd003mk3fD7d9XTPnqNPk3GQLMue91VC3W5
	xMGn0qa2RArUpWzbR6mayD90M2l7YFlZo/4KRTRD5N+4M64im2BVXqBAxHeoA0L9NbezNgS7VjM
	Q+yIESZEZlHJv6iUa2eWxBh6Th6WQ0C28HahaE/H2yGyBeBQ5TcN/DwwN0Nqb839OAtbVjXjbQ7
	I4FDf3uDPtPaPNsXzVXZbiboMhGT2w7FyEFeH0Ds1Lxlb1NCLUd5QSKbnN8KQqHTBBEmpyQOaFO
	NY9YxFLrZJ12sJSMCs7tnBPo9s9+2mlxGvN9BnirAGwAbONEA37Scrt3iKnWQ8iFZ9GPrf32b+F
	7Z3lYIf7vfLZb+4gEZHQBeki03D88fyzZJyxhcu0myY28x7E7cMQfNjIkPxrlIQuRiuK8F58iBQ
	4=
X-Received: by 2002:a05:620a:1307:b0:93f:1e3c:4a3d with SMTP id af79cd13be357-949ba9db70bmr444310285a.46.1795178823143;
        Fri, 20 Nov 2026 04:47:03 -0800 (PST)
X-Received: by 2002:a05:620a:1307:b0:93f:1e3c:4a3d with SMTP id af79cd13be357-949ba9db70bmr444305585a.46.1795178822702;
        Fri, 20 Nov 2026 04:47:02 -0800 (PST)
Received: from brgl-qcom.local ([195.50.164.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884ab091sm119248995e9.11.2026.11.20.04.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 04:47:01 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 13:46:42 +0100
Subject: [PATCH v3 05/10] of: property: implement the .property_get_names()
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
Message-Id: <20261120-fwnode-for-each-prop-v3-5-808e304dc73e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2119;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=k44LD99l6+yuoAWvft0Vpp5Uhsi3XgcWFZVnUcvzOe0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBrAEE3jVJ3t+7uOpkpf/ma2oevHqicDxvGj6rBl
 oPQT0dmTv+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCawBBNwAKCRAFnS7L/zaE
 wztCD/9paaR0X5QgLZYpSkhTLDTDj+2CoshL76CwZ1C/euxfx9tQSoQJ4gzXzbBkFkBFqsUxlyt
 GNNSODrG5PYw8EjJ7vDMp48Ttka9c9OQKOoe3eWtu+G68YsiZI3GE2aBE8b8YaKFdP/w4/S0BcG
 /PVGqrbKQT06pLdEEM9gLJnwgcDz4HmRK5DUYeBZzn7VNiC/SXFpkvwYodJ7WDrkHJAfiJj06fV
 qel4dEHCkt61LsEDdkukVtcgBmcKQbGJDMcwPke2dFdp2ap6cL2vHro+W4tWug2vb8+wNXgPbRF
 mr00uwwasIhDyZgV3eH0lUPQQIzT2v0wixQdqAXuavckz4zkemVQbMDjlwo+I/sncQobi6IdmhR
 ux+nVqVmwREhNaSHZVR+WMQMIRowp5vY1azSPvpQweYKZBmjulfqby81nbNdvEVfrQqyi/Zu+EG
 XSyc3pusKBiDGRWdWDENGtbgMsqcUyHI6KEKY1iC1QbhZdmf4OGtDuoKT+uTSALX0IOM0P+/Dmh
 Ty/QCv14O/KHiziP6X2ihEiRIhDjSVJJyO0vu7PgCORHsL+/4NcaeI0cTm6AMP6mZ8imuRR6dN+
 dS+VwgchE3FAUZHUC4CrUgMVZTRRo1OnrMOEpBmwOOU/jpCR1vkGHPLgFjDdXCT86Hbq9YxAN+h
 Jj9EW4TsfQgs0yg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: _7V_CB5fSSWYHYdk2CGKmppxwJx2p5XO
X-Authority-Analysis: v=2.4 cv=RZYFmFtv c=1 sm=1 tr=0 ts=6b004147 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=cT0tItDctYQywj5JGBkA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1MCBTYWx0ZWRfXw7rN3+W0MBBX
 SdYw5dKWcN45ZBxY2I+nY3BIypHALdFfZPl5ufUJXjzyzafB8k71rtsvuVSo3H0Ha1JOSmd/2Gs
 atylfsN24/7l3IA2v9qEO2z0YVn6c6k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1MCBTYWx0ZWRfX66e9PpCHEaKZ
 UquCki1yzJLaAKKig+COyVc43vGI5kxdhzv0TO+RFmZ8OArk/eqbpOmBrtuy9eMxzcaNuvGpfWa
 URju2JzPmzkarLz9xmD//LEI8DtLsbFTSgMU8v+k1js6iP82TRsauPMuLJ+TmM0YCegxnesW4jM
 /J+EJf3d3GmUkVHfokhQ0rcO6okKAojxEaCXu0MxVyv91XtCrgdv3stGdyUX19xfxYC5Xh/BDdT
 lQpklGkWs2AbukOTiRfv1fzuLQ2us7/XVtCXLI6U3FPqASJ1UeOuhlNsX6lp0zrriK6m+gd0ImN
 cgPsb6aolFjxJfrwNggPjGo1kG/InmZrqvB21j4k9filjvrTWcrxhUXAAXQkJRHDg+ZWonuYPlq
 yhGl8WMGK8S0N7aGQUbomZmnLGhcTy274DSn3+6LN9O5qlQhdFJPmPJ9fUPJdZ8lW8dISgAoXvQ
 2JD8zWIYP2Yus/Qb6qg==
X-Proofpoint-GUID: _7V_CB5fSSWYHYdk2CGKmppxwJx2p5XO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200050

Implement the property_get_names() callback from the fwnode interface
for OF nodes.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/of/property.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 3a272775a8b7967bc0d35d882a5856153941cef3..f914f0475e0be865afc9753fda5aa40a08a10e25 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -27,7 +27,7 @@
 #include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/of_irq.h>
-#include <linux/string.h>
+#include <linux/string_helpers.h>
 #include <linux/moduleparam.h>
 
 #include "of_private.h"
@@ -1120,6 +1120,37 @@ of_fwnode_property_read_string_array(const struct fwnode_handle *fwnode,
 		of_property_count_strings(node, propname);
 }
 
+static int of_fwnode_property_get_names(const struct fwnode_handle *fwnode,
+					char ***props)
+{
+	const struct device_node *node = to_of_node(fwnode);
+	struct property *prop;
+	int count = 0, i = 0;
+	char **names;
+
+	for_each_property_of_node(node, prop)
+		count++;
+
+	if (count == 0)
+		return 0;
+
+	names = kcalloc(count, sizeof(*names), GFP_KERNEL);
+	if (!names)
+		return -ENOMEM;
+
+	for_each_property_of_node(node, prop) {
+		names[i] = kstrdup(prop->name, GFP_KERNEL);
+		if (!names[i]) {
+			kfree_strarray(names, i);
+			return -ENOMEM;
+		}
+		i++;
+	}
+
+	*props = names;
+	return count;
+}
+
 static const char *of_fwnode_get_name(const struct fwnode_handle *fwnode)
 {
 	return kbasename(to_of_node(fwnode)->full_name);
@@ -1712,6 +1743,7 @@ const struct fwnode_operations of_fwnode_ops = {
 	.property_read_bool = of_fwnode_property_read_bool,
 	.property_read_int_array = of_fwnode_property_read_int_array,
 	.property_read_string_array = of_fwnode_property_read_string_array,
+	.property_get_names = of_fwnode_property_get_names,
 	.get_name = of_fwnode_get_name,
 	.get_name_prefix = of_fwnode_get_name_prefix,
 	.get_parent = of_fwnode_get_parent,

-- 
2.47.3

