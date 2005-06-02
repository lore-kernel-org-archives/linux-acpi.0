From: Daniel Solsona <dani-fQczH/8Hd3rnGZpH1ro7E16hYfS7NtTn@public.gmane.org>
Subject: DSDT Problems with Acer Aspire 1691WLMi
Date: Thu, 02 Jun 2005 13:18:30 +0200
Message-ID: <1117711110.7363.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi all, I just buyed an acer aspire 1691WLMi and I'm having some
problems with the acpi.

I donwloaded the custom dsdt table from acpi.sourceforge.net and the
iasl compiler version 20050513 [Jun  1 2005]

I'm having problems compiling the dsdt, those are the errors I get:

Unknown resource descriptor type [ERRORNODE]
dsdt.dsl   950:                     0x0100, 0x00,,)
Error    1094 -                                   ^ Missing
ResourceSource string (required)
........
........
........
dsdt.dsl  1063:                     , AddressRangeMemory, TypeStatic)
Error    1094 -            Missing ResourceSource string (required) ^ 

dsdt.dsl  1070:                     , AddressRangeMemory, TypeStatic,
ResourceSource)
Error    1037 -         syntax error, unexpected ',', expecting ')' ^ 

ASL Input:  dsdt.dsl - 6918 lines, 243620 bytes, 3165 keywords
Compilation complete. 18 Errors, 0 Warnings, 0 Remarks, 1116
Optimizations

I have two diferent errors, the first one and the 17 others are the
same.

After reading James Sparenberg problem, and the fix that Bruno Ducrot
told him, I tried to eliminate all the  ResourceSourceIndex but on my
dsdt there is no ResourceSourceIndex.

I have too some errors on syslog:

Jun  2 12:59:25 localhost kernel:     ACPI-0352: *** Error: Looking up
[Z00B] in namespace, AE_NOT_FOUND
Jun  2 12:59:25 localhost kernel: search_node dfa2c1a0 start_node
dfa2c1a0
return_node 00000000
Jun  2 12:59:25 localhost kernel:     ACPI-1138: *** Error: Method
execution failed [\_SB_.BAT1._BST] (Node dfa2cf80), AE_NOT_FOUND
Jun  2 12:59:26 localhost kernel:     ACPI-0352: *** Error: Looking up
[Z00B] in namespace, AE_NOT_FOUND
Jun  2 12:59:26 localhost kernel: search_node dfa2c1a0 start_node
dfa2c1a0
return_node 00000000
Jun  2 12:59:26 localhost kernel:     ACPI-1138: *** Error: Method
execution failed [\_SB_.BAT1._BST] (Node dfa2cf80), AE_NOT_FOUND


Thanks for the help






-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
