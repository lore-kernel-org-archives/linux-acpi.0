From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 5/5] ARM64: kernel: acpi: honour acpi=force command line
 parameter
Date: Wed, 25 Mar 2015 16:25:34 +0000
Message-ID: <20150325162533.GG26903@localhost>
References: <1427219940-27201-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1427219940-27201-6-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427219940-27201-6-git-send-email-lorenzo.pieralisi@arm.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 24, 2015 at 05:58:55PM +0000, Lorenzo Pieralisi wrote:
> If acpi=force is passed on the command line, it forces ACPI to be
> the only available boot method, hence it must be left enabled even
> if the initialization and sanity checks on ACPI tables fails.
> 
> This patch refactors ACPI initialization to prevent disabling ACPI
> if acpi=force is passed on the command line.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>

Better, indeed.
