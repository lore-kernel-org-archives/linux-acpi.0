From: Matthew Tippett <matthew.tippett-rieW9WUcm8FFJ04o6PK0Fg@public.gmane.org>
Subject: Determining Button State
Date: Sun, 08 Dec 2002 00:01:21 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DF2D221.7020005@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

Looking at rolling out some sort of ACPI script environment for acpid. 
Is there any way that the ACPI system determines exposes what state the 
subsystem is in.

When I close the lid on my laptop, I get the event -

button/lid LID 00000080 0000000b
button/lid LID 00000080 0000000c
button/lid LID 00000080 0000000d
button/lid LID 00000080 0000000e
button/lid LID 00000080 0000000f

Which doesn't seem to have anything that indicates 'down or up'.  I 
understand an 'up/down' doesn't make sense for Power or Sleep, but it 
seems pretty vital to something like a lid.

Regards,

Matthew
-- 
Matthew Tippett - matthew.tippett-rieW9WUcm8FFJ04o6PK0Fg@public.gmane.org - (416) 435-4118
Technology Forum - http://www.technology-forum.org/
Commercial Open Source - http://www.commercialos.org/



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
