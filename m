From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation/acpi: add the missing '='
Date: Wed, 28 Jan 2015 12:08:50 -0700
Message-ID: <20150128120850.5f6504a7@lwn.net>
References: <1421330356-4051-1-git-send-email-bywxiaobai@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421330356-4051-1-git-send-email-bywxiaobai@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yaowei Bai <bywxiaobai@163.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 15 Jan 2015 21:59:16 +0800
Yaowei Bai <bywxiaobai@163.com> wrote:

> -			.acpi_match_table  ACPI_PTR(mpu3050_acpi_match),
> +			.acpi_match_table = ACPI_PTR(mpu3050_acpi_match),

Applied to the docs tree, thanks.

jon
