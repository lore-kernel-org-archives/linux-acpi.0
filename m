From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [RFC PATCH 5/5] GHES: Make NMI handler have a single reader
Date: Thu, 23 Apr 2015 18:00:15 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F32A6446B@ORSMSX114.amr.corp.intel.com>
References: <1427448178-20689-1-git-send-email-bp@alien8.de>
 <1427448178-20689-6-git-send-email-bp@alien8.de>
 <alpine.LNX.2.00.1504010941040.843@pobox.suse.cz>
 <20150401134913.GB18523@pd.tnic>
 <alpine.LNX.2.00.1504231038470.3695@pobox.suse.cz>
 <20150423085939.GC28340@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150423085939.GC28340@pd.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@suse.de>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-edac <linux-edac@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Chen, Gong" <gong.chen@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, "Zheng, Lv" <lv.zheng@intel.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>
List-Id: linux-acpi@vger.kernel.org

PiBJIHRoaW5rIHdlIHNob3VsZCBhcHBseSB0aGlzLg0KPg0KPiBIZXJlJ3Mgd2h5OiBub3RoaW5n
IGluIHRoZSBnaGVzX25vdGlmeV9ubWkoKSBoYW5kbGVyIGRvZXMgQ1BVLXNwZWNpZmljDQo+IGFj
Y2Vzc2VzDQoNClRoaXMgbG9va3MgdG8gYmUgdHJ1ZS4NCg0KPiBUb255LCBvYmplY3Rpb25zPw0K
DQpObyBvYmplY3Rpb25zLg0KDQotVG9ueQ0K
