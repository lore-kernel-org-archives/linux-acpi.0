From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH v2 0/4] ACPI-APEI-HEST: Fine-tuning for two function
 implementations
Date: Wed, 9 Aug 2017 20:00:25 +0200
Message-ID: <9f6e5436-e550-b64c-db39-b9da668766b0@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <9834b713-2c7b-ad6d-76a5-b1db40f561fc@users.sourceforge.net>
 <CAJZ5v0hcD8pi8y+jAtF70cJp8uYyUdOeDJKuR3z=JpB6Z_Qnfw@mail.gmail.com>
 <06ab72bc-6e00-1829-f1bf-67f0a31aff38@users.sourceforge.net>
 <CAJZ5v0i5EW1UpLfaogyD-s4P4vXdgWndwjOpF5ykPDXE=eZVSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0i5EW1UpLfaogyD-s4P4vXdgWndwjOpF5ykPDXE=eZVSA@mail.gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Hanjun Guo <hanjun.guo@linaro.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, trivial@kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 9 Aug 2017 19:45:43 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Fix a typo in a comment line
  Use kmalloc_array() in hest_ghes_dev_register()
  Move an assignment in hest_ghes_dev_register()
  Reduce the scope for a variable in acpi_hest_init()

---

v2:
* Desired changes were rebased on source files from Linux next-20170803.

* The number of update steps was reduced.

 drivers/acpi/apei/hest.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.13.4
