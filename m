From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/7] ACPI-APEI-HEST: Fine-tuning for three function
 implementations
Date: Mon, 5 Sep 2016 22:12:24 +0200
Message-ID: <9834b713-2c7b-ad6d-76a5-b1db40f561fc@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <566ABCD9.1060404@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, trivial@kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: linux-acpi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Sep 2016 22:05:05 +0200

Some update suggestions were taken into account
from static source code analysis.

Markus Elfring (7):
  Fix a typo in a comment line
  Use kmalloc_array() in hest_ghes_dev_register()
  Move an assignment in hest_ghes_dev_register()
  Rename jump labels in hest_ghes_dev_register()
  Rename jump labels in acpi_hest_init()
  Reduce the scope for a variable in acpi_hest_init()
  Rename jump labels in hest_parse_ghes()

 drivers/acpi/apei/hest.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

-- 
2.10.0
