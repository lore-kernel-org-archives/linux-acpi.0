Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633127;
	b=EUhqjbwu4BZESHralXBOAxMtNetmNAiLOGsDRRbdlVZNVnAfMTHiYt182GbJcjFmZXSg
	 b/VQvm1+htuvsa160sjVSPgBo3kGWqsOA57MC34cqOA6x+pAowBZ7DQvyEK8LaZ3nyWji
	 c/E+GBUv1/MoeumJvzsbOAuiKDBFwLk1CfmqLwytI4xm4MQRm4PoPEO1jfhIn/M/rpkKR
	 OkqSCJTyHolMcO+wrXvouFh4lzNkLeGIMDpZjzDeXhUuPSJP0p27kVE0x77k1TcZwj8Dt
	 wFPolTXF8eYuYdRip+uEtVw/Xsf2RU6hB6z0QdTmGxc4kEVpinGjcBA4XQVlFJRPEaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633127;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=B1DU3LgyzTnea9+7Y3O+Bj5uaLiVMEW2UzaRAHeAVXc=;
	b=m6UG/8uSs8RCRIJJ16Q5fY48vhb1uTjD/ORPFyp0TTDcKMoWAdRzQRr3YQZXEICmfNUe
	 wObkqaIH2zszzst7MRIJBjYIi0KjAp0k5/E0ddohPkuz+CzkcnMYxwD1DkBERb6Gu+EjS
	 JPdJ16NbPdsWLvDKmVjAdRwJxMIuKfPZYpo9xtzhw3bm9Y0cNXproMpyOJj8UIEdiTAbE
	 nP6sLnoZr7bsP/4N4NoUvSzzGIR5zagcuLgKUAU7R2EqV4uyslfw9kS1pnbM4gLUZk4fb
	 nSZm8km3LUVGt/nQDZVYqFvuZG+hX+M5gxIupyvxlW/wACa3I0OvksPdIYe5dWFdVQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=myDU0FCZ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NR2vb2TI;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B40606AB8C
	for <linux-acpi@vger.kernel.org>; Mon,  2 Nov 2026 15:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77B40606AB8C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=myDU0FCZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NR2vb2TI
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DpfGT3512923
	for <linux-acpi@vger.kernel.org>; Mon, 2 Nov 2026 15:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=B1DU3LgyzTnea9+7Y3O+Bj
	5uaLiVMEW2UzaRAHeAVXc=; b=myDU0FCZNxFZ0+UuUVqd8cbtxPQlaPOIHcckkb
	FdnPCo2ZNxjuZrYkMP9AeKd8mqT2ShdpEsqsHHJEPU3+Vy7uUhHLZn66aI9xdotH
	NPjJrMkLNgFS1Q/KpH0fm/Pb+AxPmv0D84fWWfoFF0LTezhGQtGUrSgM55UY4Ixp
	+7jaK2sqgr/ZHiG7SE260tqRu0jFKP8und/znrsMjfhE7NWCRtu7TEP/M0Hb81Km
	H/AS4CkaBjK62jmKZNB/xlIqyeXgrmBuutiJWiDNqahyLkezf+5NgtrVjos9YAFM
	9wJDxzIfIrN1Onh/g0Pz75m1qHeYZs6tdyTZWcD2g7OIP2Ow==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpqfrhhm9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 02 Nov 2026 15:25:26 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7cc48fbca26so488381137.3
        for <linux-acpi@vger.kernel.org>; Mon, 02 Nov 2026 07:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793633125; x=1794237925; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=B1DU3LgyzTnea9+7Y3O+Bj5uaLiVMEW2UzaRAHeAVXc=;
        b=NR2vb2TIReEvv07JJ8y/HQ20wAnLi+Ye9NGbTVljrMCXxF+/rEJ+znG+FW7SwhozpL
         YA6YEy2i2Nntw7a/rfZQAqd2XKSPuc7gIuKEbw6Zj5Uqz5FJ2Vbb7yWEIH/cW8b7z5D/
         qsNkRp9V31QXLvRD5jB6p7NvX0TwxAGwZLixms57t3EeL8PM0DMx1ssohg3HXxKBgdH1
         LBKukiVkChsV1C288aiWKt1vITg13/dUTEhzCEZyjLy8teY6VCj3YozqKEmzMAptgjAl
         f8bhWhnW5uMuH+zCWjDV8P3kQHRQdaJ464mCVrl7rXb55iiLwgVrwF8Rejyd/VYAh8te
         Di+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633125; x=1794237925;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=B1DU3LgyzTnea9+7Y3O+Bj5uaLiVMEW2UzaRAHeAVXc=;
        b=uEWWRlKwL2GGe70cMZ9u1tWeSsWpEn9m0kKUfDED4fN6P48mq9KNZywxl+g9fwsgwQ
         DMHpVorRb/4NKVHxlHBMbo6j85HDXMqCikuYqAXugdFB0nfye3ffNfbDGzU0keBPtaYp
         3b1kDQPgakTHZJeSxTPB54k6umQLvZuRgPqpyFWPq2wS1EuDE5Jqdn9Hy/TSzFc/ti9k
         QaHCOTHaW2lDVW9p/GyjQFERdmGVvzvmrK6prfbcEyni9/YieUiJMC41oJzj8RaKof4r
         64S0KOwHIP7oMfln4spSeF/x2EdzOIyLq7Iq5NRcwQzGIpf5zOScS3hWHkrQK953n+0j
         4zzA==
X-Forwarded-Encrypted: i=1; AKwUvBw4jhYbX9H/6E9/CXekgWyPPdzIto5VlgFmFIfk0HNzsHg5DNnQE4TAvFfRS3MOF0ACn+OqYnKMx8dn@vger.kernel.org
X-Gm-Message-State: APuU4Z++Va7llMAjSDzntSoyLi248my39UGyRPi5WYfYMarIA+w+ZVso
	RVZxDaKqSTyTsfGmV3tq4C6UTUKDVaIzhkXJogauZtigt8kesvyWOm9VH3nr3+aJREg5k1ar5XT
	Dwl1QSelEZq92aEsBtLfEKO/fYuIZgSBBXNkUvG1AMvOfn44+NxImrV7RzQYAAuLo
X-Gm-Gg: AYBFou3gzWfSg20v/8f3MEMuAqx/If7nB8d+NUNjGZl7jHChSdoJvNsCXnF3FxNLEKa
	uFWv04bumjnGmlLKkadmA0G8laaHrZ/xOMGQqH8Rih2WIhcYze/hgLp4UNEQI84jK+RbQXRty3m
	33wfsBdoSXQyyikhpQLp5brSS4jtHRpGhk4XFStcx8CY7oftoj/8aweAFJ7HtKOn8uHOrkdC8V1
	9QAYgj2wlVWinarHcEufnk73d0abafnJhdP448R38jLJj0QfLOkCzFZ5HM25P/bnb8DvLYTEO6b
	+nfO1lx2w9NyTpKaZvmrUKPsT1eZr3L9Xk0S8DziD23ocjjjQPwtcQCpJXiD12aOOI6SPHaIVK0
	yDQqRD5t2x9983gTLB1rGMZb598l2KaiCR2zx2vC+XMVQ9C25a39gQVTtJmpglFagUYe6B7x+pt
	xJ8Q==
X-Received: by 2002:a05:6102:6883:b0:7a7:5355:7fb6 with SMTP id ada2fe7eead31-7d07267f930mr3504244137.24.1793633125429;
        Mon, 02 Nov 2026 07:25:25 -0800 (PST)
X-Received: by 2002:a05:6102:6883:b0:7a7:5355:7fb6 with SMTP id ada2fe7eead31-7d07267f930mr3504234137.24.1793633124952;
        Mon, 02 Nov 2026 07:25:24 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8a5a7sm21652200f8f.37.2026.11.02.07.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:25:24 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 16:25:16 +0100
Subject: [PATCH] software node: only let the owner release a managed node
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
Message-Id: <20261102-swnode-only-owner-release-v1-1-ee4c9022a629@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFur6GoC/x3MQQqDQAxG4atI1g2YsVXoVUoX4vy2AcmUBKoi3
 r1Dl9/ivYMCrgi6Nwc5vhparEIuDU3v0V5gzdWU2tSLtIljtZLBxZady2pwdiwYA3y9Yc7TIKm
 DUO0/jlm3//vxPM8fZWxn+2sAAAA=
X-Change-ID: 20261102-swnode-only-owner-release-45efdc7123e1
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3090;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ZleP3PDhw48f6cSLIdCsOL2mkkUrCTAfo49Savej+/g=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq6KtgROPX0Epo5EG5AuMUFPtRwBKX3Zpzdmuat
 gzc/czvDxKJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCauirYAAKCRAFnS7L/zaE
 w0zgD/9HdeUt+9DhTQ+gmK2a/h1PphwvGSXwJr5tJ8k4iV+a5lZuUw5zHNgYZVba6pPQODBuSUn
 ICF6icCO/T0PD+Yn4HxOeeeH2UxCfifc6pltgu+D8bxLjCAaM+KVwT8HEgGoyRRz7wczL8NioXf
 Qw3GDFZ5DOsd330nle7vnIg4JHusBCGL5SBU46P23MUssjLL26JLQI/8LCAOEZcJO6SMevDOxCt
 5VrRXW7yIrpn0Zru+r4GEkR6o4NnZYiibBzmlJ2PK3lZWka/qeTiZx4to8jrle/Fr47E4F8EQd+
 bcYJqTUtfMhjwEUTDpQhfJxlvebUAFzlfFvVolhg6pOchiDNh9tfHx8ywM32PcrXf2Q1u9dF3P3
 S1YeuQI5ULGuVM+M+le8YzOKFqfSJSAyMB8FCISZREWeuDOCL7cCzh57jByottXRJukxQpnI75i
 PdGir0BvyPHBS+Rt+Jyvofz/EyxBxE0lXFF3o1IgnY6IYp5XpUd0u3DDOvrY/SBQwu/ZK4J7p5n
 sidjlciuvQAGNj8vxqEwVHjGonti2CWrHxVXVNlbEcusqBQ1VPIeXbCnmwh8BN9xLVXNwAKSE8N
 J2ioIR7vJE0vgbBElce+ej6gNYFx5H5B8r0/kFgj3h/ba92e4TdOq2cq+8P99AErSHzIzsumBbY
 fKvj+C7zZ4qCunw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=HMJWhYtv c=1 sm=1 tr=0 ts=6ae8ab66 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=fRiVfNsCqIIJhZuQGKsA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: Eq55NNiGhlNi1EOdLXsg8tSO5nSTxIyn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2MSBTYWx0ZWRfX3unrbQRUzt1A
 pkKmDkgb8oJ2EdsbAQYFfRRKol3VkbX6xH/ss7SXk9wZJ6S25VhWaTzT5Cyv0/eP19OsRlXURg2
 kL+QTH/21Fxbvze75BioFXtIPmtcLfA=
X-Proofpoint-ORIG-GUID: Eq55NNiGhlNi1EOdLXsg8tSO5nSTxIyn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2MSBTYWx0ZWRfX9YQUi3JTvKky
 EserAmW0doKPTSb7pm4HK48rpsw9xbkqTSaeo3zZyjHmTrU3/K0Xolk79WHfnIN+S3a934TVNOz
 tvhRI9Jqlp7Lih1qQ6ccpoWE4/nMQifvd/zrl6ffX0ie71JI8xevQRy6K5zKeFzroft9ZKgpUDC
 wGPehzIC9vmoWjSXYkPVGrJ9RGGCy/kje/76I1eKlUwG2VdpjtkjsQavdfa8wIjbWvVYVCB8PZ4
 l3vO0XqpfZv7MCEnWgJtXVw2Z4mHtj08vddINGif6gcoTqnG1s/ogya4Qk7VFY4UMjP932HyLCo
 I9UF8MOCykP2Q/iJ8fyarTZwvrQeXBXfLukTClI20WGoOMZWAQPf0T19y9dUCbPR59VxbZ6elVi
 KZ4v4GHjmm0nghyMcgL9iyuxjXwggz6zuJrQ9240DrI90p+C4SmctPBf2zhIlYva16yfKoI/d90
 8UtcfK87yz9ekv8/1rA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020061

device_create_managed_software_node() creates a node whose lifetime is
tied to the device it was created for. software_node_notify_remove() is
called for every device that has the node as its fwnode (primary OR
secondary) and, if the node is managed, unconditionally detaches it from
that device and drops the creation reference.

This breaks when the node is shared with another device. Example: the
i2c-designware copies the parent's fwnode to the adapter's struct device.
When the adapter is deleted, it releases the reference that belongs to
the owner and the latter ends up with a dangling pointer.

Record the device's "manager" and only perform the actual release when
notify is called for that "owner" device.

Reported-by: Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>
Closes: https://lore.kernel.org/all/20261009164241.923756-2-balasubramani.vivekanandan@intel.com/
Fixes: 151f6ff78cdf ("software node: Provide replacement for device_add_properties()")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Hi!

This is my approach at addressing the bug reported by Vivekanandan
directly in driver core. Please test it if you can.

Thanks,
Bartosz
---
 drivers/base/swnode.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 84a77ffa3dc4bbcca62bbe67c3390693500b01ea..abb6d6d59d59cb4e605fc31cc7e89f92e9f900a6 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -29,6 +29,8 @@ struct swnode {
 	struct fwnode_handle fwnode;
 	const struct software_node *node;
 	int id;
+	/* Device the managed node's lifetime is tied to. */
+	struct device *owner;
 
 	/* hierarchy */
 	struct ida child_ids;
@@ -37,7 +39,6 @@ struct swnode {
 	struct swnode *parent;
 
 	unsigned int allocated:1;
-	unsigned int managed:1;
 };
 
 static DEFINE_IDA(swnode_root_ids);
@@ -1145,7 +1146,7 @@ int device_create_managed_software_node(struct device *dev,
 	if (IS_ERR(fwnode))
 		return PTR_ERR(fwnode);
 
-	to_swnode(fwnode)->managed = true;
+	to_swnode(fwnode)->owner = dev;
 	set_secondary_fwnode(dev, fwnode);
 
 	if (device_is_registered(dev))
@@ -1190,6 +1191,7 @@ void software_node_notify(struct device *dev)
 void software_node_notify_remove(struct device *dev)
 {
 	struct swnode *swnode;
+	bool is_owner;
 
 	swnode = dev_to_swnode(dev);
 	if (!swnode)
@@ -1206,9 +1208,13 @@ void software_node_notify_remove(struct device *dev)
 	if (!device_match_fwnode(dev, &swnode->fwnode) && swnode->fwnode.dev == dev)
 		swnode->fwnode.dev = NULL;
 
+	is_owner = swnode->owner && swnode->owner == dev;
+	if (is_owner)
+		swnode->owner = NULL;
+
 	swnode_put(swnode);
 
-	if (swnode->managed) {
+	if (is_owner) {
 		set_secondary_fwnode(dev, NULL);
 		swnode_put(swnode);
 	}

---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
change-id: 20261102-swnode-only-owner-release-45efdc7123e1

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

