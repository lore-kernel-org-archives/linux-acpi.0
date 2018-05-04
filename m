From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 2/2] ACPI: APD: Add AMD misc clock handler support
Date: Fri, 04 May 2018 12:06:51 +0200
Message-ID: <3734664.7VekyYX7C7@aspire.rjw.lan>
References: <1525422930-27826-1-git-send-email-akshu.agrawal@amd.com> <1525422930-27826-2-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525422930-27826-2-git-send-email-akshu.agrawal@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: djkurtz@chromium.org, Alexander.Deucher@amd.com, Len Brown <lenb@kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Friday, May 4, 2018 10:34:44 AM CEST Akshu Agrawal wrote:
> AMD SoC exposes clock for general purpose use. The clock registration
> is done in clk-st driver. The MMIO mapping are passed on to the
> clock driver for accessing the registers.
> The misc clock handler will create MMIO mappings to access the
> clock registers and enable the clock driver to expose the clock
> for use of drivers which will connect to it.
> 
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> ---
> v2: Submitted with dependent patch, removed unneeded kfree for devm_kzalloc

Well, where's patch [1/2]?

Thanks,
Rafael
