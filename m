Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801072;
	b=LVXU6KiR/nQgeGPYpeLJYgpd9JieAPYkdC7fJhIIGzKM+UR8RAs24hOvOjbO3Y8K9Yyu
	 E7QJg+Y8vQu40iXMzLvZqqF82s/wHdWbdsF7+8sgzX4tj7E/fvoH2e/Yfl5l/vdmwjkZx
	 UWgr/Fz85jJezI2K6YtbeJBHIRAyEdbTi7RcuA096Fs/rL5q8zdw6gSPEwdx8iAkm3l5K
	 PpT96SavScbXcsuyaINVeo4oIYDXui/6kqIkGp9N0TgviYJ27eo25yL2jIrU/hgKP7qZE
	 eMO8X20X0AqIiCBXuaHnVXAMfp6Lv7rQSGovri181ZHEQbaIaFhANhrVDW7ysO6VCZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801072;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=R9H2Enry7Lq5ox0n9An9Ex70nh2Mbgn/+cNEyqjd8q8=;
	b=HPXSkn7gys+CgrTzUIYeP1BUWtuplK2VMuuKJ1/BaQJtb4hxAERcODRMIixuzPhQSUMA
	 Ly209R/iyUv4lIoX9DOPdsWGSxVsedEc7pQhxYLw97D45q0Nai9/mED7ozqgx6lSnANLe
	 UiTUKpf0n3LukuFNJP4rPTqVkhepCn6Ur74dQNkQJBOvdmz2NWNVt7LRRJ/c5wGoLgK7l
	 /w7DT0mwvk2O4S2Uac/EJh2Gw7Aj31C6NKh14l4a6mnTfCiZDUn54PvlovdZI6l1pANMW
	 7Fp1QPNctw6sm51nTARdb/ir57L3bnvIA14IUPh6by6pYkiFp1fY+6UrQCeAnAM5SAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W8TE8KXW;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BOgz3yJ1;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEBA606D812
	for <linux-acpi@vger.kernel.org>; Wed,  4 Nov 2026 14:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBEBA606D812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W8TE8KXW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BOgz3yJ1
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4BZt8D2667764
	for <linux-acpi@vger.kernel.org>; Wed, 4 Nov 2026 14:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R9H2Enry7Lq5ox0n9An9Ex70nh2Mbgn/+cNEyqjd8q8=; b=W8TE8KXWhAa7mSse
	KqJyND/Uo3fINN8csA0WHZcbmFl7o58YkQE6yUYKCSKHoncFZiEhoUB9yB/IcGpY
	lv5bJhF9J6qBLZIjG8jyykN936enW2UF1OG9Uj/4xGwFwk9jUQRRtOjGGqWzsmpa
	RTf9H3EWCGZa4z70OSauZu9/CtxDdBs/ZCrm6SH0ojWgMurFD9Y1jLXJnR3rqlwz
	yj+YdduA/Cu6kaCsFKOTCKzuYtUr1TmmfvVVGEV5NJz/s43L1P/VdA63capDaYVE
	WxfbYInzK5O6PFMX3QQ5vxuGTY3886ta/cwtsQh0Man9dDcVV36m2GvXwM41XBOP
	zCge3A==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqm2pmef6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 04 Nov 2026 14:04:31 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-98c73709b84so570952241.0
        for <linux-acpi@vger.kernel.org>; Wed, 04 Nov 2026 06:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793801070; x=1794405870; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R9H2Enry7Lq5ox0n9An9Ex70nh2Mbgn/+cNEyqjd8q8=;
        b=BOgz3yJ1/5c3CstAfICtLSmp56m/9Gj2CoA0C1mYy1dD2rZuz7ppTds2js9js4WMjo
         +sYVTr/DlznNMrFr0BzaGj8ROx2m4+6hY3XME6EAs+2ZmJThK5ZQmplcSAsniNaHBCiW
         HYrVXTgwjh30nvoEquncraiZD1dlpk9J2uZgFqDo0yhthpRagM+RDH1ffmzgZkkPtOSt
         2bASLpbt5z3pj/3wY/fXO1PhuwYcGE3brAp4WAq9J10rVcyptHvL/3bOhZycP8aVXjLn
         m7eLCsNpQvSJq2SwmrUHxbhqZwfplNcTSrMPHvEVzhDX45qom3XhimglnlxZoSJzNw+2
         Pi/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793801070; x=1794405870;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R9H2Enry7Lq5ox0n9An9Ex70nh2Mbgn/+cNEyqjd8q8=;
        b=KxDwb6ss0Y3AP9aaPn3A/X+TF6bWgeN2f82C7Hr0+yJ4bpmRo7+JKget1h7Wyca619
         VEBthdgW8ysgTMRZqONSorsiIwzLQllaqS7XAEn2gHdsYwIUEk02jCtER7v88SS85lot
         BjtYeFlgMbgTKpsVH7VUNgynolsk7xsBI01Yt41oFtUYWMpCutC/It+Ju1TaaQwpmn7E
         sF29FMAIqZjdjzlGMFUZCNuyissfPUS49h5ind6S0jSTuiE9RRGyw7PjzWoLjNCVqxTx
         aw6F8Q90ZbFenHG7idHdK1RhiH5yMV56LcSAyPYX0ETASDcSmhYW6aKgLbNrOa9IjDaX
         YB/g==
X-Gm-Message-State: APuU4Z+XZaNacaASb8GByuGOPv0eIZAL4xi4OZPU19mTtM6Xe7BwZSQK
	p0YEhVH/8aVXI4jiejaJlLG2Pql34pXLTM0hoMyetI3ra3sc3sKVIeVkVvEYN+m4bNM3k/pN9iO
	5GTGTHPS+afxvpJLY++d1j968/5/upy0UbSFZJWjxM1GW9e8ENSK0KFWLbgAKRFA8
X-Gm-Gg: AYBFou2k0GuQgXgocYJiLVu8756G3KvVuKv8/G3TMJrvVEG29U2LACqoo7sHIUac3lc
	ila76rQwkOHuTsSSVRbbFo8rQgUMkpGsKRErzTMH73nrr8nyXwpEOu75GmZm3lpGZ4ZX5ZH8kn7
	kWPV4dLhVm0PKL4gqktBsNYO+aGrSCJPI0zpMZST6kLxNu+kH1laLykGO8F/j/ZUcTtVZOcfveq
	pAhlK65AJtxmFgQOd9unODfI3Itpvn6RkIz96QkJZ7hOyeRIE3ew84BBxvP6Xcwu2Zo7pTLFJed
	BxckCDdtbOWLHaBwkU1T8f9/EK9cKS6FW2kk1b/1NkxD9EfAfqtDlvfFLG4uTT0C7Git8h/P6wC
	/c9seg3aVRVtVjW+GPpdfnX3UBn7ssog1KwHCRmK0RlS+8Vo12wWguGxbg32ndJyjHXJWgNzliV
	0Dsw==
X-Received: by 2002:a05:6122:2491:b0:5ea:c90d:d1b2 with SMTP id 71dfb90a1353d-5ec68993be9mr6944321e0c.13.1793801070097;
        Wed, 04 Nov 2026 06:04:30 -0800 (PST)
X-Received: by 2002:a05:6122:2491:b0:5ea:c90d:d1b2 with SMTP id 71dfb90a1353d-5ec68993be9mr6944269e0c.13.1793801069615;
        Wed, 04 Nov 2026 06:04:29 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d87b5sm3968358f8f.11.2026.11.04.06.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:04:28 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 04 Nov 2026 15:03:47 +0100
Subject: [PATCH 5/9] of: property: implement the .property_get_names()
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
Message-Id: <20261104-fwnode-for-each-prop-v1-5-6e28fe1c72c4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2033;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=CUearllheTUa0mAxFBQA4rgfpmwyh1HyyvDmdireIIM=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq6ztSMudMNgYFqcJmZ0DLcgsCP+qirtdi2op3S
 //eoHjcXWuJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaus7UgAKCRAFnS7L/zaE
 w5yqD/952xG+8H9EKe/LRTYijZFEaI7dbjICEKB8Nx0sjEwcYjqdBdkX0oHDq9Q/140tjPQSf+u
 qUdmFsX0hn6S820xkPwyyBg4+AE0oQYD+GabGX23mtxW1HzzaXaX0EE/EIO7Rgq9eQxtDqbPLK9
 kbqiniYPqMBbaBmtmjWgVwuJ0foj+FXKTtw95VwYd95a1/fV+cGb3OXffG3FflbxIXHVxZ0p9IH
 VA0B9agIHy8sRzm+pJKufG2sd5PGB8NLotn+zNMLTJbiRvJxXO/TPluKWty89//xYOQt8gr5jvW
 0OOIVr+vnBwi96VTpN0KBoxhE2acadMuU5PVAmFNNpUdiialK77WyltSv20jRrG3mzarDMctQL4
 /rI3XmjAyOWxrgQmoLx8REtpu/BbdheaZTlXUee00w49zypxx6QxsnzhRvYoUSBYAaDy2Fc1esh
 OSuUqmpLnhRVF1RfozKZOKpUgfq3hoi6R144EPidufa1CVMmfvk4s28C8diZQb706YSNBPlJCsj
 x/Zi0ljFw0fH+hlrBrb2K4PBvX7HduzJCxpPIbR8V4SzAaS5Vp5jrhJhlDGzDbALi5G7uE4CRt5
 QF3KnUhWpvDRhzBn+K6fbv8UXdtVrrFfiVnhJE1I79zRBKUWOhJ53fubnCpzH+/9Kit1B4lUnbx
 gRgmnYNRA18XMmQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1NSBTYWx0ZWRfX3yvdJYZIOm97
 aFMYmFds1lDtvDIXvIOZAn07KriAcyTfi9Rzz/W7eWAjzTfLsCBSwferw2w49jYJ7QzItI4c5sc
 ClDO0XIRWmLUwG7tg5Pp8FjgB2rqqrCz0JvuGP9Gz3DlkhoNdA6FJLivkt19ef4iE/b258m+/OC
 vVBlWzlIonnI2PBR0CWNlIl/2hDHSiGxlJMyqEVUahhlbRaygTErFRHEgT0L/a73Aq+TWNd9CHF
 5irDnT9cL/YNbNtjDR7HrMCzCYNrliLvM/0/GXz5zCwQ2W8ek6fFWPXDC2FXvyW1vAKZuFzDSOn
 CkJuXsrKWIZ3adLn9Z63IJTZVpaAvd79whUwc/wxf5cd8xXXpOjrw6crWM3qNdtD5YbOUxry29m
 4+ZBwMShW4fDZE2VIJeBHjkzg+RcxUjDnrOCw95Z8udLecIlpZ18pLrfuJmClmdyG5vLY5wlzki
 mMQmwV+DvuaYMILQmVQ==
X-Proofpoint-GUID: LK4mSqf6Q9NwHSY5WyulpCWFzplApuSc
X-Proofpoint-ORIG-GUID: LK4mSqf6Q9NwHSY5WyulpCWFzplApuSc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1NSBTYWx0ZWRfXyue5cMNQJXwN
 TrugCm5jNMMcc3ExHv+M/c5qRgTnvMGpiqzQfYZOGoImCBhMBsr9wVnHqm65H8wZga1mKw8l+k2
 iLl4Um6lQ+NXV/SBXdPVXHn//ToFFlM=
X-Authority-Analysis: v=2.4 cv=c64+0h9l c=1 sm=1 tr=0 ts=6aeb3b6f cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=QAC4ccWuAPOjo8k0q0QA:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040055

Implement the property_get_names() callback from the fwnode interface
for OF nodes.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/of/property.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 45e55f61848801ed497702c6cfe501009904c49d..16c9c307633bdc7c9343782b1cd3bdb845552c6a 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -28,6 +28,7 @@
 #include <linux/of_graph.h>
 #include <linux/of_irq.h>
 #include <linux/string.h>
+#include <linux/string_helpers.h>
 #include <linux/moduleparam.h>
 
 #include "of_private.h"
@@ -1120,6 +1121,34 @@ of_fwnode_property_read_string_array(const struct fwnode_handle *fwnode,
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
@@ -1712,6 +1741,7 @@ const struct fwnode_operations of_fwnode_ops = {
 	.property_read_bool = of_fwnode_property_read_bool,
 	.property_read_int_array = of_fwnode_property_read_int_array,
 	.property_read_string_array = of_fwnode_property_read_string_array,
+	.property_get_names = of_fwnode_property_get_names,
 	.get_name = of_fwnode_get_name,
 	.get_name_prefix = of_fwnode_get_name_prefix,
 	.get_parent = of_fwnode_get_parent,

-- 
2.47.3

