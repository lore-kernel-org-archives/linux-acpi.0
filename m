From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH 3/4] mailbox: pcc: optimized pcc_send_data
Date: Wed, 20 Jan 2016 17:29:08 -0500
Message-ID: <CAJ5Y-ebHmNNjzt8j=REpmOxuGCFEHU1saK0k6BPkg2-2ZzFk1Q@mail.gmail.com>
References: <1452883415-24452-4-git-send-email-pprakash@codeaurora.org> <201601160304.RK00pi2j%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35837 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934687AbcATW3a (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jan 2016 17:29:30 -0500
Received: by mail-lb0-f170.google.com with SMTP id bc4so13400937lbc.2
        for <linux-acpi@vger.kernel.org>; Wed, 20 Jan 2016 14:29:28 -0800 (PST)
In-Reply-To: <201601160304.RK00pi2j%fengguang.wu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: Prashanth Prakash <pprakash@codeaurora.org>, kbuild-all@01.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux acpi <linux-acpi@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>

On 15 January 2016 at 14:33, kbuild test robot <lkp@intel.com> wrote:
> Hi Prashanth,
>
> [auto build test ERROR on pm/linux-next]
> [also build test ERROR on v4.4 next-20160115]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
>
> url:    https://github.com/0day-ci/linux/commits/Prashanth-Prakash/acpi-cppc-optimization-patches/20160116-024434
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> config: i386-allmodconfig (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All errors (new ones prefixed by >>):
>
>    drivers/mailbox/pcc.c: In function 'read_register':
>>> drivers/mailbox/pcc.c:195:10: error: implicit declaration of function 'readq' [-Werror=implicit-function-declaration]
>       *val = readq(vaddr);
>              ^
>    drivers/mailbox/pcc.c: In function 'write_register':
>>> drivers/mailbox/pcc.c:221:3: error: implicit declaration of function 'writeq' [-Werror=implicit-function-declaration]
>       writeq(val, vaddr);
>       ^
>    cc1: some warnings being treated as errors

You probably need to include asm-generic/io.h

Thanks,
Ashwin.

>
> vim +/readq +195 drivers/mailbox/pcc.c
>
>    189                  *val = readw(vaddr);
>    190                  break;
>    191          case 32:
>    192                  *val = readl(vaddr);
>    193                  break;
>    194          case 64:
>  > 195                  *val = readq(vaddr);
>    196                  break;
>    197          default:
>    198                  pr_debug("Error: Cannot read register of %u bit width",
>    199                          bit_width);
>    200                  ret_val = -EFAULT;
>    201                  break;
>    202          }
>    203          return ret_val;
>    204  }
>    205
>    206  static int write_register(void *vaddr, u64 val, unsigned int bit_width)
>    207  {
>    208          int ret_val = 0;
>    209
>    210          switch (bit_width) {
>    211          case 8:
>    212                  writeb(val, vaddr);
>    213                  break;
>    214          case 16:
>    215                  writew(val, vaddr);
>    216                  break;
>    217          case 32:
>    218                  writel(val, vaddr);
>    219                  break;
>    220          case 64:
>  > 221                  writeq(val, vaddr);
>    222                  break;
>    223          default:
>    224                  pr_debug("Error: Cannot write register of %u bit width",
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
