Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795515552;
	b=Lsz4/vFNUmEHVq2Y64cm2JH4jb7OgZs82E/5qEhZN2Xvumanl/e4D8sA9glj+ts+EpuA
	 pz2JA8uieKPMaGoewu1a23sny1bxuXi37vio7wWbaQNKPL/fc793FXEWc7xgNJ35LUTdw
	 uDuB/qQoJyFUKMa/ASTsEj5G7MH8AUcXITcWNlJz3pEsouWAob6+27h0hA3YFVa/jAnLQ
	 IJrz7AxFVST93yqCVTGshkvQnUdM+65ZgpHGlVJI7N/DEotvcBpxabLe+GyXIPrrKNH1J
	 rLN/YIP6cguRAN2d+xfdDYiVQiLhiXewWZ8PM/mNaxUjyBvUy/KROZ6fqtusIzGJR+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795515552;
	h=DMARC-Filter:DKIM-Signature:EX-QQ-RecipientCnt:X-QQ-GoodBg:
	 X-BAN-DOWNLOAD:X-BAN-SHARE:X-QQ-SSF:X-QQ-FEAT:X-QQ-BUSINESS-ORIGIN:
	 X-QQ-Originating-IP:X-Originating-IP:X-QQ-STYLE:X-QQ-mid:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:X-BIZMAIL-ID:
	 X-Address-Ticket:X-QQ-SENDSIZE:Received:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=BamssN9WTBctTCc+ML35GfBHII2/mMm7UQhWi0uZH/Q=;
	b=rXc1GQHimLsRmKUPOffmpXkN8yZ/1+Jj1QrLUjNaDuN3MasY7+Z5fnqSMooOduhYI24o
	 HzFkGoiih8p5RhiVAATfZ/hpRTbx1DFe5vD1x2ypo/Jnhi8eQmdpw9VMcBgWJ5I9aksNd
	 hHHAhwhQLTGNxMC7b40HMevVue7aifX9J2A7NMLHO5kOcElQQlqK67/WN0tdBKR2hOVHe
	 YUHPZtpGXM7wBTgePRpSfpzNXSNKAcpdppj7p/NHn2By7D92HC0aVq4sl2v1bmNFdC1or
	 kc4EJFnyQjKpFD5ad3NecU33p4x9sCfJSPwLUwYwiK6QigAiP0yutt1oRsYFXs8fkEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mails.ccnu.edu.cn;
	spf=pass smtp.mailfrom=mails.ccnu.edu.cn;
	dkim=pass header.d=mails.ccnu.edu.cn header.i=@mails.ccnu.edu.cn header.a=rsa-sha256 header.s=dabk2403 header.b=R8+qiTUb;
	arc=none smtp.remote-ip=54.254.200.92
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F23606A332
	for <linux-acpi@vger.kernel.org>; Tue, 24 Nov 2026 10:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5F23606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mails.ccnu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ccnu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mails.ccnu.edu.cn header.i=@mails.ccnu.edu.cn header.a=rsa-sha256 header.s=dabk2403 header.b=R8+qiTUb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mails.ccnu.edu.cn;
	s=dabk2403; t=1795515526;
	bh=BamssN9WTBctTCc+ML35GfBHII2/mMm7UQhWi0uZH/Q=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=R8+qiTUbo+lfoACA8pUmXhFp/uEGxfmI7TQRp9umCYOtsBY1uUvExJQK74EEOFs/q
	 Gu7gZagC88AurRodZ4AFdWpmgZA9jrIuq2yRu99haV0wvco+CyItTjydU+MmOnzgO3
	 lqgoGaptmBBsMFYOd5jedz5Dk9yTiRM/B3de1JJM=
EX-QQ-RecipientCnt: 3
X-QQ-GoodBg: 2
X-BAN-DOWNLOAD: 1
X-BAN-SHARE: 1
X-QQ-SSF: 0040000000000020
X-QQ-FEAT: D4aqtcRDiqRcMYJqMribwNe7Sq6XkWjGXFnSrAw/+Mw=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: jaQL4TpJ7S+scmsEKaRQ62KCKJNdrMTwV8oWNtXitl8=
X-QQ-STYLE: 
X-QQ-mid: lv4gz3a-0t1795515522td107faee
From: "=?utf-8?B?6YeR5bq3?=" <jin2371488344@mails.ccnu.edu.cn>
To: "=?utf-8?B?bGludXgtYWNwaQ==?=" <linux-acpi@vger.kernel.org>
Cc: "=?utf-8?B?dG9ueS5sdWNr?=" <tony.luck@intel.com>, "=?utf-8?B?YnA=?=" <bp@alien8.de>
Subject: GHES/CPER admission ordering in confidential VMs - research note before submission
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Tue, 24 Nov 2026 18:18:42 +0800
X-Priority: 3
Message-ID: <tencent_709C91C3048D70ED0C1F505A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 3539056520258496067
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Tue, 24 Nov 2026 18:18:43 +0800 (CST)
Feedback-ID: lv:mails.ccnu.edu.cn:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: Me3hdGK5nWP4qZRHWwx3/ilqTI3lmn7pP7n/iOgvtpLquhkNlAIViMWA
	zCLEBBOyYQKqKfNOtSM34rkAA0gryBCnkqzzLWJCqY0yPoCo3vDr2/dKEw2GeXl+QVi9/a4
	joySMNa79lIVmR/Np/q5zDzSlJaItPBxh8iXRO7v5YvZHWoP+8AslF4KVp0BMq/Lis2daVB
	0awNijXXgJJfblTGEfw9+BpmX5e4YoH/1pENWn7dkgeJFw2+CPSPklwR2UAC+ShjRCev5Y+
	sST0a1BZK7/zawO5e6nLXEETY6CQe4Yw42NxEYLr6S7fjUUM7DZfWhjW3EYqRhJ3Z5cJLdP
	TVGUe0frFuLWE5ouq2evcMpGsK2oc4X2ZTqVtPu00taWcVydyocxu8HtnAW1C/wYM+/cgnf
	ZjtruZXReM+c4SEf5GakoVl5KYjijS3pF5eCr3g19iegTOIW4eqgRR6Zhmbnbg3OybOr0A3
	WuCyIuv3/VWgiUdUBZ/zDfL+5kYB7c6/kaPpGiYN/WWPKn9bBvhvinjmucmwJmhMK7bhhss
	h99uMYdmKoksn8nxStId5Z/a2b8uDJ0WYUze6paiVYWlAFYiuN+lJusAwbBFWBd70CwtvS/
	vMCQHnhGchIAIcOYnDFPfODVfFocEWEdSe96HAbQ8Ca2mPBb6r7CRDMAKliVVdNvdY4Fokb
	KTH+Vr5lDCOPQ0L8gXl3glZ8XDpjM8j7xIKZ7VL+NDUzI5mRCkB7G/SBxDSejAsX+OediUe
	dpgm9A2l/fu3BR+wI+ZnmL3D8T9/F3RXC7EdwQLEl28IrR3ROeLXica+Ycifdjv8+2PorfS
	uJKiPXjbHv1OlUoWb+cHur7DFBSNZVlfOfU3FYdCY9ZyooDFkVYYKgzfNkd1K4V5YHnLmG0
	svDuqufvpA9/by6VtH+9FvhmI7+RFSNGSabGbNE4j1ZwMj6WqQoqFdyIPnkOl1UiMoZyEJy
	s5OEAZCzLY4xTklKdxO+HWpHgDoQEFFwjRA0kbwxiZ+AUBt04OhE4SMXLXryCVRTUYhb15G
	IX8q2kSYOMaTJEuJcew+/DtvDUHH4=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

SGVsbG8sDQoNCkkgYW0gcHJlcGFyaW5nIGEgcGFwZXIgZm9yIHRoZSBKb3VybmFsIG9mIENv
bXB1dGVyIFNlY3VyaXR5LCBwcm92aXNpb25hbGx5DQp0aXRsZWQgIkZvcmdlZEZhdWx0OiBB
ZG1pc3Npb24gQ29udHJvbCBmb3IgSG9zdC1BdXRob3JlZCBIYXJkd2FyZS1FcnJvcg0KVGVz
dGltb255IGluIENvbmZpZGVudGlhbCBWTXMiLiBJdCBpcyBub3Qgc3VibWl0dGVkIHlldC4g
SSBhbSB3cml0aW5nDQpiZWZvcmUgc3VibWlzc2lvbiBzbyB0aGF0IHRoZSBrZXJuZWwgc2lk
ZSBjYW4gYmUgcmV2aWV3ZWQgaW5kZXBlbmRlbnRseSBvZg0KdGhlIHBhcGVyLiBJIGFtIG5v
dCByZXBvcnRpbmcgYSBDVkUgYW5kIEkgYW0gbm90IHB1Ymxpc2hpbmcgYW4gZXhwbG9pdC4N
Cg0KV2hhdCBJIG9ic2VydmVkLiBPbiBMaW51eCA1LjE1LCA2LjgsIGFuZCA3LjMtcmM3LCB0
aGUgR0hFUyBtZW1vcnktZmFpbHVyZQ0KcGF0aCByZWNvcmRzIHRoZSBlcnJvciBpbiB0aGUg
Z3Vlc3QncyBNQ0UvRURBQyBoaXN0b3J5IGJlZm9yZQ0KbWVtb3J5X2ZhaWx1cmUoKSBydW5z
IGFuZCBiZWZvcmUgYW55IHBhZ2UgYWN0aW9uIChyZXRpcmVtZW50IG9yDQpzb2Z0LW9mZmxp
bmUpIGlzIHF1ZXVlZC4gQSBDUEVSIHRoYXQgcGFzc2VzIHRoZSBzdHJ1Y3R1cmFsIGFuZCBk
ZWNsYXJlZA0KY2hlY2tzIGlzIHRoZXJlZm9yZSBlbnRlcmVkIGFzIGhhcmR3YXJlIGhpc3Rv
cnkgZXZlbiBpZiB0aGUgcGFnZSBhY3Rpb24gaXMNCnN1YnNlcXVlbnRseSBibG9ja2VkLiBJ
IHRyZWF0IHRoaXMgYXMgYW4gb3JkZXJpbmcgYW5kIGFkbWlzc2lvbiBwcm9ibGVtIGF0DQp0
aGUgR0hFUyBlbnRyeSwgbm90IGFzIGEgQ1BFUiBwYXJzZXIgYnVnLg0KDQpPbmUgcXVhbGlm
aWNhdGlvbiBkZWNpZGVzIHdoZXRoZXIgdGhpcyByZXByb2R1Y2VzLiBJbiBhIFREWCBndWVz
dCB0aGUgR0hFUw0Kc3RhdHVzIGJsb2NrIGlzIG1hcHBlZCBwcml2YXRlIGJ5IGRlZmF1bHQs
IHNvIGEgc3RvY2sgZ3Vlc3QgcmVhZHMgbm90aGluZw0KdGhlIGhvc3Qgd3JpdGVzOiBvbiB0
d28gcmVudGVkIGJhcmUtbWV0YWwgVERYIGhvc3RzLCAwIG9mIDUgc3RvY2sgYm9vdHMNCnJl
YWQgYSByZWNvcmQuIFRoZSBwYXRoIGFib3ZlIGlzIHJlYWNoYWJsZSB3aGVuIHRoZSB0ZW5h
bnQgbWFwcyB0aGUgYmxvY2sNCnNoYXJlZCwgd2hpY2ggaXMgaG93IGZpcm13YXJlLWZpcnN0
IFJBUyBpcyBjb25maWd1cmVkOyB3aXRoIHRoYXQgb25lDQpndWVzdC1zaWRlIGxpbmUsIGV2
ZXJ5IGJvb3QgdGhhdCBvZmZlcmVkIHRoZSByZWNvcmQgY29uc3VtZWQgaXQgKDMvMyBhbmQN
CjQvNCksIGxlYXZpbmcgYW4gTUNFL0VEQUMgZW50cnksIGFuZCB0aGUgcmVjb3ZlcmFibGUg
cmVjb3JkIHRoYXQgbmFtZWQgYQ0KdmljdGltIHRlcm1pbmF0ZWQgaXQgb24gaXRzIG5leHQg
YWNjZXNzICgxLzEgb24gZWFjaCBob3N0KSB3aGlsZSB0aGUgb3RoZXINCmZpdmUgcHJvY2Vz
c2VzIGNvbnRpbnVlZC4gT24gU0VWLVNOUCB0aGUgc2FtZSBkZWxpdmVyeSBpcyBhIHNvdXJj
ZQ0KYXJndW1lbnQsIG5vdCBhIG1lYXN1cmVtZW50OiBpdCBob2xkcyBvbmx5IGlmIHRoZSBn
dWVzdCBzaGFyZXMgdGhlIGJsb2NrDQphbmQgbm8gcGFyYXZpc29yIGF1dGhlbnRpY2F0ZXMg
b3IgZmlsdGVycyB0aGUgcmVjb3JkLiBUaGUgdHdvIGNvbW1lcmNpYWwNCmluc3RhbmNlcyBJ
IGluc3BlY3RlZCByZWFkLW9ubHkgKG9uZSBURFgsIG9uZSBTTlAsIG9uZSByZWdpb24gZWFj
aCkgaGFkIG5vDQpIRVNUIGF0IGFsbC4gU28gdGhpcyBpcyBhIGxhdGVudCBvcmRlcmluZyBh
bmQgdHJ1c3QtYm91bmRhcnkgaXNzdWUsIG5vdCBhDQpsaXZlIGV4cGxvaXQgYWdhaW5zdCBh
biB1bm1vZGlmaWVkIHNoaXBwaW5nIFZNLg0KDQpXaHkgY29udGVudCBjaGVja3MgZG8gbm90
IGNsb3NlIGl0LiBJZiB0aGUgaG9zdCBjb3BpZXMgYSBnZW51aW5lIHJlY29yZA0KYnl0ZSBm
b3IgYnl0ZSwgbm8gZGVjaXNpb24gdGhhdCByZWFkcyBvbmx5IHRoZSByZWNvcmQgYW5kIHB1
YmxpYyBjb25zdGFudHMNCmNhbiBzZXBhcmF0ZSB0aGUgY29weSBmcm9tIHRoZSBvcmlnaW5h
bC4gSSB1c2UgdGhhdCBhcyBhIGJvdW5kIG9uDQpjb250ZW50LW9ubHkgZmlsdGVycywgbm90
IGFzIGFuIGV4cGxvaXQgcmVjaXBlLg0KDQpXaGF0IEkgaW1wbGVtZW50ZWQgYW5kIG1lYXN1
cmVkLiBBIGZhaWwtY2xvc2VkIGFkbWlzc2lvbiBnYXRlIGF0IHRoZSBHSEVTDQplbnRyeSwg
Y292ZXJpbmcgYm90aCB0aGUgcG9sbCBwYXRoIGFuZCB0aGUgTk1JIHBhdGgsIHdpdGggcmVm
dXNlZCByZWNvcmRzDQpnb2luZyB0byBhIGNsZWFybHkgbWFya2VkIHJhdy1vYnNlcnZhdGlv
biBsb2cgaW5zdGVhZCBvZiB0cnVzdGVkIHN0YXRlLiBJDQptZWFzdXJlZCBpdCBvbiBRRU1V
L0tWTS4gT24gYSBtb2RpZmllZCBURFggdHJlZSBJIGNvbXBpbGVkIGFuZA0KYm9vdC1tZWFz
dXJlZCBpdCBidXQgZGlkIG5vdCBydW4gaXQgZW5kIHRvIGVuZC4gSSBkaWQgbm90IG1lYXN1
cmUgZ2VudWluZQ0KRUNDIGV2ZW50cywgYW5kIEkgZG8gbm90IGNsYWltIHByb2R1Y3Rpb24g
YXZhaWxhYmlsaXR5Lg0KDQpXaGF0IEkgd291bGQgbGlrZSB0byBhc2suDQoNCjEuIElzIGEg
cXVhcmFudGluZSBvciBkZW55IG9wdGlvbiBhdCB0aGUgR0hFUyBlbnRyeSBhY2NlcHRhYmxl
IHVwc3RyZWFtLA0KICAgZ2l2ZW4gdGhhdCBpdCBhbHNvIHJlZnVzZXMgZ2VudWluZSBmaXJt
d2FyZS1maXJzdCByZXBvcnRzIG9uIHRoZSBzYW1lDQogICBjaGFubmVsPw0KMi4gU2hvdWxk
IHRoZSBOTUkgcGF0aCBzaGFyZSB0aGUgc2FtZSBnYXRlLCBvciBpcyB0aGVyZSBhIHJlYXNv
biB0byBrZWVwDQogICB0aGUgdHdvIGVudHJ5IGZhbWlsaWVzIHNlcGFyYXRlPw0KMy4gSXMg
dGhlcmUgYW4gaW4tYm91bmRhcnkgcHJvZHVjZXIgZGVzaWduIHRoZSBtYWludGFpbmVycyB3
b3VsZCBjb25zaWRlcg0KICAgdHJ1c3R3b3J0aHkgZm9yIGEgcG9zaXRpdmUgYWNjZXB0YW5j
ZSBwb2xpY3k/IFdpdGggbm8gc3VjaCBwcm9kdWNlciwgdGhlDQogICBvbmx5IHNvdW5kIHBv
bGljeSBJIGNhbiBydW4gaXMgZGVueS1hbGwsIGFuZCB0aGF0IGlzIGEgY29tcGxldGVuZXNz
IGNvc3QNCiAgIEkgZG8gbm90IHdhbnQgdG8gaGlkZS4NCg0KU3RhdHVzLiBJIGhhdmUgbm8g
Zml4ZWQgZGF0ZSBmb3IgdGhlIHByZXByaW50IG9yIGZvciB0aGUgam91cm5hbA0Kc3VibWlz
c2lvbi4gSSB3aWxsIHNlbmQgdGhlIGFyWGl2IElEIGJlZm9yZSB0aGUgcHJlcHJpbnQgZ29l
cyBwdWJsaWM7IGlmDQp5b3Ugd291bGQgbGlrZSB0byBzZWUgdGhlIHJlbGV2YW50IHNlY3Rp
b25zIGZpcnN0LCBvciB3YW50IG1vcmUgdGltZSwgdGVsbA0KbWUgYW5kIEkgd2lsbCBhcnJh
bmdlIGl0LiBUaGUgcGF0Y2ggYW5kIHRoZSBtZWFzdXJlbWVudCBzY3JpcHRzIGFyZQ0KYXZh
aWxhYmxlIG9uIHJlcXVlc3Q7IEkgaGF2ZSBub3QgYXR0YWNoZWQgdGhlbS4NCg0KU2luY2Vy
ZWx5LA0KS2FuZyBKaW4NCldvbGxvbmdvbmcgSm9pbnQgSW5zdGl0dXRlLCBDZW50cmFsIENo
aW5hIE5vcm1hbCBVbml2ZXJzaXR5KENDTlUpDQpqaW4yMzcxNDg4MzQ0QG1haWxzLmNjbnUu
ZWR1LmNu

