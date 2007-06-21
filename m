From: Tim Gardner <tim.gardner@canonical.com>
Subject: ACPI Regression on Dell E1501
Date: Thu, 21 Jun 2007 15:04:33 -0600
Message-ID: <467AE7E1.4050805@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758555AbXFUV0R@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

Commit e9e2cdb412412326c4827fc78ba27f410d837e6e breaks boot on a Dell
E1501 unless 'acpi=off' is specified (also tried nolapic and nohpet but
it made no substantive difference). This laptop is an 'AMD Turion(tm) 64
X2 Mobile Technology TL-50' CPU, but its booting 32 bit SMP (make
defconfig). No kernel built after this commit works for this platform.

There is no crash output, it just wedges after 'NET: Registered protocol
family 2'.

How can I debug this problem?

rtg
-- 
Tim Gardner tim.gardner@ubuntu.com
