From: "Jan Beulich" <JBeulich@novell.com>
Subject: [PATCH 0/2] acpi: section annotation adjustments in processor
	 driver
Date: Thu, 17 Feb 2011 16:32:46 +0000
Message-ID: <4D5D5BBE02000078000327A5@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

1/2: use __init where possible
2/2: use __cpuinit for the acpi_processor_set_pdc() call tree

Signed-off-by: Jan Beulich <jbeulich@novell.com>

