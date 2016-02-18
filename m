From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH V2] acpi, pci, irq: account for early penalty assignment
Date: Thu, 18 Feb 2016 09:12:19 -0600
Message-ID: <56C5DF53.9030709@codeaurora.org>
References: <1455801582-21595-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1455801582-21595-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, cov@codeaurora.org
Cc: linux-pci@vger.kernel.org, ravikanth.nalla@hpe.com, lenb@kernel.org, harish.k@hpe.com, ashwin.reghunandanan@hpe.com, bhelgaas@google.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Sinan Kaya wrote:
> @@ -968,3 +978,4 @@ void __init acpi_pci_link_init(void)
>   	register_syscore_ops(&irqrouter_syscore_ops);
>   	acpi_scan_add_handler(&pci_link_handler);
>   }
> +

Unrelated whitespace change.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation collaborative project.
