From: Chris Bainbridge <chris.bainbridge@gmail.com>
Subject: [BUG] ACPI Error: Needed type [Reference], found [Integer]
Date: Tue, 28 Feb 2017 00:29:12 +0000
Message-ID: <20170228002912.GA5546@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Moore, Robert" <robert.moore@intel.com>, LKML <linux-kernel@vger.kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>
List-Id: linux-acpi@vger.kernel.org

Latest Linux git has ACPI errors on Macbook IVB:

[    0.333133] ACPI Error: Needed type [Reference], found [Integer] ffff880261656f30 (20170119/exresop-103)
[    0.333141] ACPI Exception: AE_AML_OPERAND_TYPE, While resolving operands for [Store] (20170119/dswexec-461)
[    0.333150] ACPI Error: Method parse/execution failed [\_PR.CPU0._PDC] (Node ffff8802628c60c8), AE_AML_OPERAND_TYPE (20170119/psparse-543)

[    0.517073] ACPI Error: [\_PR_.CPU0._CST] Namespace lookup failure, AE_NOT_FOUND (20170119/psargs-363)
[    0.517084] ACPI Error: Method parse/execution failed [\_PR.CPU1._CST] (Node ffff88026173b618), AE_NOT_FOUND (20170119/psparse-543)
[    0.517267] ACPI Error: [\_PR_.CPU0._CST] Namespace lookup failure, AE_NOT_FOUND (20170119/psargs-363)
[    0.517279] ACPI Error: Method parse/execution failed [\_PR.CPU2._CST] (Node ffff88026173b640), AE_NOT_FOUND (20170119/psparse-543)
[    0.517464] ACPI Error: [\_PR_.CPU0._CST] Namespace lookup failure, AE_NOT_FOUND (20170119/psargs-363)
[    0.517474] ACPI Error: Method parse/execution failed [\_PR.CPU3._CST] (Node ffff88026173b668), AE_NOT_FOUND (20170119/psparse-543)

Bisect leads to:

ce87e09dd88c61f9088768a7708828423549725c is the first bad commit
commit ce87e09dd88c61f9088768a7708828423549725c
Author: Bob Moore <robert.moore@intel.com>
Date:   Wed Dec 28 15:29:43 2016 +0800

    ACPICA: Parser: Allow method invocations as target operands
    
    ACPICA commit a6cca7a4786cdbfd29cea67e84b5b01a8ae6ff1c
    
    Method invocations as target operands are allowed as target
    operands in the ASL grammar. This change implements support
    for this. Method must return a reference for this to work
    properly at runtime, however.
    
    Link: https://github.com/acpica/acpica/commit/a6cca7a4
    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Lv Zheng <lv.zheng@intel.com>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
