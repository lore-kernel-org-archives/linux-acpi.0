From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] ACPI / property: fix data node parsing in acpi_get_next_subnode
Date: Fri, 18 Mar 2016 01:44:40 +0100
Message-ID: <1532954.c5y1EcfSoC@vostro.rjw.lan>
References: <1457829210-16892-1-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457829210-16892-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, Octavian Purdila <octavian.purdila@intel.com>, Cristina Ciocan <cristina.ciocan@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Sunday, March 13, 2016 02:33:30 AM Irina Tirdea wrote:
> When an ACPI node has both ACPI device nodes and ACPI data nodes,
> acpi_get_next_subnode will return the ACPI data nodes of its last
> parsed child.
> 
> Make sure that the acpi device that is parsed is the original acpi
> node and not any of its children.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>

Applied (with slightly modified changelog).

Thanks,
Rafael
